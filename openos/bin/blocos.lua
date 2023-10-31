--[[
    Pre installer:
        Pre Install (Done):
            ask user if they wanna install (Done)
            install to what hard disk (Done)
            if data found, ask if they want to quit (to switch out the hard drive) or format the hard drive (Done)

        Install:
            make folder for installer files (maybe)
            copy installer files
            ask for reboot
            ask for openloader to be installed if it doesnt upon reboot
            reboot
]]

io.write("Are you sure you wanna install this? [Y/N] ")
local InstallConfirm = io.read()

function installabort()
    io.write("\nAborting Install...")
    os.exit()
end

if string.lower(InstallConfirm) == "n" then
    installabort()
end

local fs = require("filesystem")

local cls = require("tty").clear
cls()

io.write("Select What hard drive to install to. ")
local comps = require("component").list("filesystem")
local devices = {}

-- stolen code moment
-- not all mounts are components, only use components
for dev, path in fs.mounts() do
  if comps[dev.address] then
    local known = devices[dev]
    devices[dev] = known and #known < #path and known or path
  end
end

local dev_dev = fs.get("/dev")
devices[dev_dev == rootfs or dev_dev] = nil

io.write("\n")

table.sort(devices, function(a, b) return a.path<b.path end)

local installnum = 1
local targets = {}

for dev,src in pairs(devices) do
    local selection_label = (src.prop or {}).label or dev.getLabel()
    targets[installnum] = {dev.address,dev}
    if selection_label then
        io.write(installnum..". "..selection_label.."\n")
    else
        io.write(installnum..". "..dev.address.."\n")
    end
    installnum = installnum + 1
end

io.write("Input: ")

local InstallTarget = io.read()
local TargetNumberExists = false
for i,v in pairs(targets) do
    if tonumber(InstallTarget) == i then
        TargetNumberExists = true
        break
    end
end

if not TargetNumberExists then
    io.write("Invalid (Not in list).")
    installabort()
end
if not tonumber(InstallTarget) then
    io.write("Invalid (Not a number).")
    installabort()
end

local Target = targets[tonumber(InstallTarget)]
local InstallFS = Target[2]
local Address = Target[1]

if InstallFS.isReadOnly() then
    io.write("This Drive is read only.")
    installabort()
end

cls()

if #InstallFS.list("/") > 0 then
    io.write("Data Was found on your selected drive.\n")
    io.write("Data in question:\n")
    
    for i,v in pairs(InstallFS.list("/")) do
        io.write(v.."\n")
    end

    io.write("\nFormat or End Installation? [Format/End] ")
    local DriveDataChoice = io.read()
    if string.lower(DriveDataChoice) ~= "format" then
        io.write("No files have been changed.")
        installabort()
    end
end

io.write("Formatting will occur after installer files are copied")
io.write("And the computer restarts.")

InstallFS.setLabel("BlocOS Install Target")

local internet = require("internet")
 
function Download(path)
    io.write("Installing "..path)
    local handle = internet.request("https://raw.githubusercontent.com/Bloctans/MyOS/main/installer"..path)
    local result = ""
    for chunk in handle do result = result..chunk end

    local file = InstallFS.open(path, "w")
    file:write(result)
    file:close()
end

local component = require("component")

function Download_OpenLoader()
    io.write("Flashing OpenLoader")
    local handle = internet.request("https://raw.githubusercontent.com/MightyPirates/OpenComputers/master/src/main/resources/assets/opencomputers/loot/openloader/init.lua")
    local result = ""
    for chunk in handle do result = result..chunk end

    component.eeprom.set(result)
    component.eeprom.setLabel("OpenLoader")
end

Download("/InstallList.lua")
Download("/init.lua")

Download_OpenLoader()

io.write("The OS will now reboot.")
local Reboot = io.read()

local computer = require("computer")
computer.shutdown(true)
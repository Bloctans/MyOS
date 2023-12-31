_G._OSVERSION = "BlocOS Installer v0.5"

function halt()
    while true do
        computer.pullSignal()
    end
end

-- Start component proxies, just for a bit more easier access to components
_G.bootaddr = computer.getBootAddress()

for _,v in pairs({"gpu","keyboard","filesystem","internet"}) do
    if v == "filesystem" then
        _G[v] = component.proxy(bootaddr)
    else
        _G[v] = component.proxy(component.list(v)())
    end
end

filesystem.setLabel("BlocOS Installer")

y = 1

function status(msg)
    gpu.set(1,y,msg)
    y = y + 1
end

if not internet.isHttpEnabled() then
    status("HTTP is not enabled, Installer can't continue.")
    halt()
end

-- Format

status("Formatting...")

for i,v in pairs(filesystem.list("/")) do
    if v ~= "init.lua" then
        if v ~= "InstallList.lua" then
            filesystem.remove(v)
        end
    end
end

-- Start install

status("Your Computer will now start installing Blocos.")
status("You can no longer exit out of the installer")

InstallListHandle = filesystem.open("/InstallList.lua")
InstallListFile = filesystem.read(InstallListHandle, math.maxinteger or math.huge)
filesystem.close(InstallListHandle)
local func,err = load(InstallListFile, "=/InstallList.lua", "bt", _G)
if not func then
    error("Compilation error:"..err) 
end

InstallList = select(2, pcall(func))

-- Download & install files

OSInstallURL = "https://raw.githubusercontent.com/Bloctans/MyOS/main/src"

function Request(path)
    local fullpath = OSInstallURL .. path
    local ReqHandle,Reason = internet.request(fullpath)

    local result, reason = ""

    while true do
		chunk = ReqHandle.read(math.huge)
		
		if chunk then
			result = result .. chunk
		else
			break
		end
	end

    ReqHandle.close()

    return result
end

function Download(path)
    status(path)
    local Content = Request(path)

    if path == "/init.lua" then
        local inithandle = filesystem.open("/osinit.lua", "w")
        filesystem.write(inithandle, Content)
        filesystem.close(inithandle)
    else
        local handle = filesystem.open(path, "w")
        filesystem.write(handle, Content)
        filesystem.close(handle)
    end
end


for i,v in pairs(InstallList["os"]) do
    status("Make dir for "..i)
    if i ~= "/" then
        filesystem.makeDirectory(i)
    end

    for i2,v2 in pairs(InstallList["os"][i]) do
        Download(i..v2)
    end
end

status("Done Installing! Cleaning up...")

-- Cleanup installer

filesystem.remove("/init.lua")
filesystem.rename("/osinit.lua", "/init.lua")

filesystem.setLabel("BlocOS")

-- Reboot

status("Shutting down")
computer.shutdown(true)
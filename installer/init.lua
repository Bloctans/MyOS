_G._OSVERSION = "BlocOS Installer v0.1"

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

-- Start install

status("Your Computer will now start installing Blocos.")
status("You can no longer exit out of the installer")

InstallListHandle = filesystem.open("/InstallList.lua")
InstallListFile = filesystem.read(InstallListHandle, math.maxinteger or math.huge)
filesystem.close(InstallListHandle)

InstallList = load(InstallListFile, "bt", _G)

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
    status("Downloading "..path)
    local Content = Request(path)

    status("Making File...")
    if file == "init.lua" then
        local inithandle = filesystem.open("/osinit.lua", "w")
        filesystem.write(inithandle, Content)
        filesystem.close(inithandle)
    else
        local handle = filesystem.open(fullpath, "w")
        filesystem.write(handle, Content)
        filesystem.close(handle)
    end
end


Download("/init.lua")

--[[for i,v in pairs(InstallList) do
    for i2,v2 in pairs(InstallList[v]) do
        
    end
end]]

-- set labels and stuff
-- Cleanup installer
-- Reboot

halt()
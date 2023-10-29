_G._OSVERSION = "BlocOS Installer v0.1"

-- Start component proxies, just for a bit more easier access to components
_G.bootaddr = computer.getBootAddress()

for _,v in pairs({"gpu","keyboard","filesystem","internet"}) do
    if v == "filesystem" then
        _G[v] = component.proxy(bootaddr)
    else
        _G[v] = component.proxy(component.list(v)())
    end
end

-- Format

y = 1

function status(msg)
    gpu.set(1,y,msg)
    y = y + 1
end

status("Your Computer will now start installing Blocos.")
status("You can no longer exit out of the installer")

InstallListHandle = filesystem.open("/InstallList.lua")
InstallListFile = filesystem.read(InstallListHandle, math.maxinteger or math.huge)
filesystem.close(InstallListHandle)

InstallList = load(InstallListFile, "bt", _G)

-- Download & install files
-- set labels and stuff
-- Cleanup installer
-- Reboot
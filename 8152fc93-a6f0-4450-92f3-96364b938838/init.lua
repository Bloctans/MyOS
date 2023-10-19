--[[
    local ok, err = xpcall(main, debug.traceback)

    if not ok then
        printError(err)
    end

    traceback code
]]

local addr = computer.getBootAddress()
local gpu = component.list("gpu")()

_G._OSVERSION = "BlocOS Pre-Alpha 0.0.3"
component.invoke(gpu,"set",1,1,_G._OSVERSION)

component.invoke(gpu,"set",1,2,"Start MPath")

-- Incase you wanna move the OS base
_G.SYSROOT = "sys/"
_G.ROOT = "/"

function MPath(_path)
    return _G.ROOT.._G.SYSROOT .. _path
end

-- Basic GPU setup

component.invoke(gpu,"set",1,3,"Initalize basic Require API")

-- Initalizes Require API
local handle = assert(component.invoke(addr, "open", MPath("base/baseloading.lua")))
local readed = component.invoke(addr, "read", handle, math.maxinteger or math.huge)
component.invoke(addr, "close", handle)

local func,err = load(readed, "="..MPath("base/baseloading.lua"), "bt", _G)
local err, result = pcall(func)

_G.baseloading = result

component.invoke(gpu,"set",1,4,"Start Boot script")

baseloading.loadandinit("base/boot.lua")
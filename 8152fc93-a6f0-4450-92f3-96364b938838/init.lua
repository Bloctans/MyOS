-- This will help you bloc: https://stackoverflow.com/questions/48629129/what-does-load-do-in-lua

local addr = computer.getBootAddress()

-- Initalizes Require API
local handle = assert(component.invoke(addr, "open", "/libraries/base/require.lua"))
local readed = component.invoke(addr, "read", handle, math.maxinteger or math.huge)
component.invoke(addr, "close", handle)

local func,err = load(readed, "=/libraries/base/require.lua", "bt", _G)
if func then
    _G.require = func
else error("Compilation error:", err) end

require("/libraries/base/boot.lua").init()
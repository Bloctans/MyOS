--[[
    local ok, err = xpcall(main, debug.traceback)

    if not ok then
        printError(err)
    end

    traceback code
]]

local gpu = component.list("gpu")()
local addr = computer.getBootAddress()

_G._OSVERSION = "BlocOS Alpha 0.4"
component.invoke(gpu,"set",1,1,_G._OSVERSION)

--[[if tonumber(string.sub(_VERSION,7,7)) < 3 then
    component.invoke(gpu,"set",1,2,"Invalid LUA version")
    component.invoke(gpu,"set",1,3,"5.3 or higher needed.")
    component.invoke(gpu,"set",1,5,"Press any key to shut down.")
    component.invoke(gpu,"set",1,6,"Click to continue with possible errors.")

    while true do
        local sigerr = {computer.pullSignal()}
    
        if sigerr[1] == "key_down" then
            computer.shutdown()
        else
            break
        end
    end
end]]

component.invoke(gpu,"set",1,2,"Start MPath")

-- Incase you wanna move the OS base
_G.SYSROOT = "sys/"
_G.ROOT = "/"

function MPath(_path, sys)
    --[[if not sys then

    end]]
    return _G.ROOT.._G.SYSROOT .. _path
end

function errorwrap()
    component.invoke(gpu,"set",1,3,"Start Init basic Require API")

    -- Initalizes Require API
    local handle = assert(component.invoke(addr, "open", MPath("base/baseloading.lua")))
    local readed = component.invoke(addr, "read", handle, math.maxinteger or math.huge)
    component.invoke(addr, "close", handle)

    local func,err = load(readed, "="..MPath("base/baseloading.lua"), "bt", _G)
    local err, result = pcall(func)

    _G.baseloading = result

    component.invoke(gpu,"set",1,4,"Start Boot script")
    baseloading.loadandinit("base/boot")
end

local invoke = component.invoke

local ok, err = xpcall(errorwrap, debug.traceback)
local lines = {}

if not ok then
    for s in err:gmatch("[^\r\n]+") do
        table.insert(lines, s)
    end
    invoke(gpu,"set",1,10,"A surious error occured.  ")
    invoke(gpu,"set",1,11,"Click to view error.  ")
    invoke(gpu,"set",1,12,"Press any key to restart.  ")
    invoke(gpu,"set",1,13,"                                 ")
    computer.beep(1000,0.5)
end

while true do
    local sigerr = {computer.pullSignal()}

    if sigerr[1] == "key_down" then
        computer.shutdown(true)
    elseif sigerr[1] == "touch" then
        for i,v in pairs(lines) do invoke(gpu,"set",1,i+13,v.."  ") end
    end
end
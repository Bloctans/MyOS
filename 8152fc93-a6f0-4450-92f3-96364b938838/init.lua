local gpu = component.list("gpu")()
_G.bootaddr = computer.getBootAddress()

_G._OSVERSION = "BlocOS Alpha 0.4"
component.invoke(gpu,"set",1,1,_G._OSVERSION)

component.invoke(gpu,"set",1,2,"Start MPath")

-- Incase you wanna move the OS base
_G.SYSROOT = "sys/"
_G.ROOT = "/"

function MPath(_path, sys)
    return _G.ROOT.._G.SYSROOT .. _path
end

-- Inital error handler
function errorwrap()
    component.invoke(gpu,"set",1,3,"Start Init basic Require API")

    -- load the package system
    local handle = assert(component.invoke(bootaddr, "open", MPath("base/baseloading.lua")))
    local readed = component.invoke(bootaddr, "read", handle, math.maxinteger or math.huge)
    component.invoke(bootaddr, "close", handle)

    local func,err = load(readed, "="..MPath("base/baseloading.lua"), "bt", _G)
    local err, result = pcall(func)

    _G.baseloading = result

    -- start boot script
    component.invoke(gpu,"set",1,4,"Start Boot script")
    baseloading.loadandinit("base/boot")
end

local invoke = component.invoke

-- error wrapper start
local ok, err = xpcall(errorwrap, debug.traceback)
local lines = {}

-- creates the error dialog
if not ok then
    for s in err:gmatch("[^\r\n]+") do
        new = ""
        for i = 1, #s do
            local c = s:sub(i,i)
            if c:byte() > 31 then
                new = new..c
            end
        end
        table.insert(lines, new)
    end
    invoke(gpu,"set",1,10,"A surious error occured.  ")
    invoke(gpu,"set",1,11,"Click to view error.  ")
    invoke(gpu,"set",1,12,"Press any key to restart.  ")
    invoke(gpu,"set",1,13,"                                 ")
    computer.beep(1000,0.5)
end

-- key down = restart
-- click = view error
while true do
    local sigerr = {computer.pullSignal()}

    if sigerr[1] == "key_down" then
        computer.shutdown(true)
    elseif sigerr[1] == "touch" then
        for i,v in pairs(lines) do invoke(gpu,"set",1,i+13,v.."  ") end
    end
end
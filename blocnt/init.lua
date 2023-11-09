gpu = component.list("gpu")()

TargetW, TargetH = 80, 25
MaxW, MaxH = component.invoke(gpu,"maxResolution")

function halt()
    computer.beep(1000,0.4)
    if TargetH > MaxH then component.invoke(gpu,"set",1,MaxH-1,"Sudden Halt. Any key to restart")
    else component.invoke(gpu,"set",1,TargetH-1,"Sudden Halt. Any key to restart") end
    
    while true do
        local sigerr = {computer.pullSignal()}

        if sigerr[1] == "key_down" then
            computer.shutdown(true)
        end
    end
end

function Wrapper()
    BootMount = computer.getBootAddress()
    Boot = "/Boot/"

    TargetW, TargetH = 80, 25

    if TargetW > MaxW or TargetH > MaxH then
        component.invoke(gpu,"set",1,1,"Max Resolution is less than the Boot manager")
        component.invoke(gpu,"set",1,2,"Target Resolution, The system cannot continue.")
        component.invoke(gpu,"set",1,3,"(Please use at least a tier 2 graphics card)")
        return
    end

    -- TODO: Memory check

    component.invoke(gpu,"setResolution",TargetW, TargetH)

    local exists = component.invoke(BootMount, "exists", Boot.."Bootmgr.lua")
    if exists then
        local handle = component.invoke(BootMount, "open", Boot.."Bootmgr.lua")
        local readed = component.invoke(BootMount, "read", handle, math.maxinteger or math.huge)
        component.invoke(BootMount, "close", handle)

        local func,err = load(readed, "=Bootmgr.lua", "bt", _G)
        func()
    else
        component.invoke(gpu,"set",1,1,"Bootmgr Is Missing.")
        return
    end
end

local invoke = component.invoke

local ok, err = xpcall(Wrapper, debug.traceback)
local lines = {}

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
    invoke(gpu,"set",1,1,"(Level 0 Error)  ")
    invoke(gpu,"set",1,2,"A surious error occured.  ")
    invoke(gpu,"set",1,3,"Click to view error.  ")
    invoke(gpu,"set",1,4,"Press any key to restart.  ")
    invoke(gpu,"set",1,5,"                              ")
    computer.beep(1000,0.5)
else
    halt()
end

-- key down = restart
-- click = view error
while true do
    local sigerr = {computer.pullSignal()}

    if sigerr[1] == "key_down" then
        computer.shutdown(true)
    elseif sigerr[1] == "touch" then
        for i,v in pairs(lines) do invoke(gpu,"set",1,i+5,v.."  ") end
    end
end
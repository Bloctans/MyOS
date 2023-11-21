-- Error Level 2 (BSOD), and Initalizes KrnlLibs (Processes, Keyboard and stuff), Calls kmumb.lua after

local Pullsignal = computer.pullSignal

function RaiseBugCheck(Msg)
    BaseComponents.GPU.setBackground(0x0000FF)
    BaseComponents.GPU.setForeground(0xFFFFFF)
    BaseComponents.GPU.fill(1,1,MaxW, MaxH," ")

    computer.beep(1000,1)

    BaseComponents.GPU.set(1,1,"(Level 2 Error)")
    BaseComponents.GPU.set(1,2,"Your computer has run into a problem and needs to restart.")
    BaseComponents.GPU.set(1,3,"Press Any Key to restart")
    BaseComponents.GPU.set(1,5,"Error Info:")

    local lines = {}
    for s in Msg:gmatch("[^\r\n]+") do
        new = ""
        for i = 1, #s do
            local c = s:sub(i,i)
            if c:byte() > 31 then
                new = new..c
            end
        end
        table.insert(lines, new)
    end

    for i,v in pairs(lines) do BaseComponents.GPU.set(1,i+5,v) end

    while true do
        local sigerr = {Pullsignal()}
        if sigerr[1] == "key_down" then computer.shutdown(true) end
    end
end

KernelLibs = {""}
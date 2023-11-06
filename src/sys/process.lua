-- Processes, Multithreading
Process = {}

--[[
    Statuses:
        0: Process.lua, doesnt exist
        1: Existing Process
        2: Non-existing Process (Ended)
]]

Process.processes = {{0, "processes", "no"}}

function Process.Find()
    for i,v in pairs(Process.processes) do
        if v[4] == coroutine.running() then
            return v[3],v
        end
    end
end

function Process.EventLoop()
    if coroutine.running() then
        if select(1,Process.Find())["stop"] then
            error("Process Stopped.")
        end
    end
end

function Process.New(name, path)
    local File = package.loadfile(path)
    local Process_ID = #Process.processes + 1
    local Process_Thread = coroutine.create(function(...)
        local ProcessOK, ProcessResult = pcall(File)
        return ProcessOK, ProcessResult
    end)

    Process.processes[Process_ID] = {1, name, {
        ["stop"] = false
    }, Process_Thread}
    return coroutine.resume(Process_Thread)
end

function Process.List()
    -- TODO
end

function Process.Close(id)
    if not Process.processes[id] then
        error("Cannot end process (Doesn't exist)")
    end

    if Process.processes[id][1] == 0 then
        error("Cannot end process (Critical Process)")
    elseif Process.processes[id][1] == 2 then
        error("Cannot end process (Dead Process)")
    end

    Process.processes[id][3]["stop"] = true
    Process.processes[id] = {2}
end

return Process
Loadfile = {}

local invoke = component.invoke

function Loadfile.Load(path, env)
    local exists = invoke(BootMount, "exists", path)
    if exists then
        local handle = assert(invoke(BootMount, "open", path))
        local buffer = ""
        
        repeat
            local data = invoke(BootMount, "read", handle, math.maxinteger or math.huge)
            buffer = buffer .. (data or "")
        until not data

        invoke(BootMount, "close", handle)
        local func, err = load(buffer, "=" .. path, "bt", env or _G)
        if func then
            return func
        else error("Compilation error:"..err) end
    else
        return "NotFound"
    end
end

return Loadfile
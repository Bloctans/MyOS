-- A very basic require function to start our base API!

addr = computer.getBootAddress()

function loadfile(_path)

    local handle = assert(component.invoke(addr, "open", _path))
    local readed = component.invoke(addr, "read", handle, math.maxinteger or math.huge)
    component.invoke(addr, "close", handle)

    local func,err = load(readed, "=".._path, "bt", _G)
    if func then
        return func
    else
        error("Compilation error:", err)
    end
end

function dofile(file)
    local program, reason = loadfile(file)
    if program then
        local result = table.pack(true, program())
        if result[1] then
            return table.unpack(result, 2, result.n)
        else
            error(result[2])
        end
    else
        error(reason)
    end
end

b = function(a)
    dofile(a)
end

return b
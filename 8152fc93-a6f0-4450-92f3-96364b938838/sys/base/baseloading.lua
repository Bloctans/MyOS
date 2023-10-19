-- A very basic require function to start our base API!

addr = computer.getBootAddress()
loading = {}

invoke = component.invoke

function loading.loadfile(_path)
    _path = MPath(_path)
    local handle = assert(invoke(addr, "open", _path))
    local readed = invoke(addr, "read", handle, math.maxinteger or math.huge)
    invoke(addr, "close", handle)

    local func,err = load(readed, "=".._path, "bt", _G)
    if func then
        return func
    else error("Compilation error:"..err) end
end

-- TODO: name vars lol
function loading.require(_path)
    local c = loading.loadfile(_path)
    c()

    return select(2, pcall(c))
end

function loading.loadandinit(_path)
    loading.loadfile(_path)()
end

return loading
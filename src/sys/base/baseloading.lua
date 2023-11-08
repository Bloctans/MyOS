-- A very basic require function to start our base API!

addr = computer.getBootAddress()
loading = {}

invoke = component.invoke

function loading.merge(_path, table)
    error("Do not use this")
    if not table then
        table = {}
    end

    sucess, mergetable = pcall(loading.require(_path))

    for i,v in select(2, pcall(loading.require(_path))) do
        table[#table + 1] = v
    end

    return table
end

function loading.doesexist(_path)
    local _path = MPath(_path)..".lua"

    return component.filesystem.exists(_path)
end

function loading.loadfile(_path, nodompath)
    if not nodompath then
        _path = MPath(_path)..".lua"
    end
    local handle = assert(invoke(addr, "open", _path))
    local readed = invoke(addr, "read", handle, math.maxinteger or math.huge)
    invoke(addr, "close", handle)

    local func,err = load(readed, "=".._path, "bt", _G)
    if func then
        return func
    else error("Compilation error:"..err) end
end

function loading.require(_path)
    local file = loading.loadfile(_path)
    file()

    return select(2, pcall(file))
end

function loading.loadandinit(_path)
    return loading.loadfile(_path)()
end

return loading
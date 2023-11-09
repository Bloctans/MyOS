package = {}

--[[package.Loaded = {
    ["Loadfile"] = Loadfile
}]]

package.Sys = "/Main/Sys/"

function package.MakePath(Path)
    return package.Sys..Path
end

function package.Require(path)
    local path = package.MakePath(path)
    local PkgEnv = {}

    local Package = LoadFile.Load(path, PkgEnv)
    Package()

    return select(2, pcall(Package))
end

function package.RequireG(path)
    local path = package.MakePath(path)

    LoadFile.Load()
end


return package
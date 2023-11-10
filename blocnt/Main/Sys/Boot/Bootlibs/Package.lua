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
    if Package == "NotFound" then
        BootMGRError("Couldnt find file: "..path)
    else
        Package()

        return select(2, pcall(Package))
    end
end
function package.RequireG(path)
    local path = package.MakePath(path)

    local Package = LoadFile.Load(path)
    if Package == "NotFound" then
        BootMGRError("Couldnt find file: "..path)
    else
        Package()

        return select(2, pcall(Package))
    end
end


return package
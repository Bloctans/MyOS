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

    local Package = Loadfile.Load(path, PkgEnv)
    if Package == "NotFound" then
        BootMGRError("Couldnt find file: "..path)
    else
        Package()

        return select(2, pcall(Package))
    end
end

function package.Do(path)
    local path = package.MakePath(path)
    local PkgEnv = {}

    local Package = Loadfile.Load(path, PkgEnv)
    if Package == "NotFound" then
        BootMGRError("Couldnt find file: "..path)
    else
        Package()
    end
end

function package.RequireG(path)
    local path = package.MakePath(path)

    local Package = Loadfile.Load(path)
    if Package == "NotFound" then
        BootMGRError("Couldnt find file: "..path)
    else
        Package()

        return select(2, pcall(Package))
    end
end

function package.DoG(path)
    local path = package.MakePath(path)

    local Package = Loadfile.Load(path, _G)
    if Package == "NotFound" then
        BootMGRError("Couldnt find file: "..path)
    else
        Package()
    end
end

return package
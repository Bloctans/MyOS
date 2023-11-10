Package = Loadfile.Load("/Main/Sys/Boot/Bootlibs/Package.lua")
if Package == "NotFound" then
    BootMGRError("Couldnt find file: "..path)
else
    Package()

    Package = select(2, pcall(Package))
end 
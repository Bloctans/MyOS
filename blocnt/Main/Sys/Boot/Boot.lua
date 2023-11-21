Package = Loadfile.Load("/Main/Sys/Boot/Bootlibs/Package.lua")
if Package == "NotFound" then
    BootMGRError("Couldnt find file: "..path)
else
    Package()
    Package = select(2, pcall(Package))
end 

Components = Package.RequireG("Boot/Bootlibs/Components.lua")

BaseComponents = {
    ["BaseFS"] = component.proxy(BootMount),
    ["GPU"] = Components.Proxy("gpu")
}

BaseComponents.GPU.setResolution(MaxW,MaxH)
BaseComponents.GPU.setBackground(0x000000)
BaseComponents.GPU.setForeground(0xFFFFFF)
BaseComponents.GPU.fill(1,1,MaxW, MaxH," ")

BaseComponents.GPU.set(MaxW/2 - 4, MaxH/2, "Starting")
BaseComponents.GPU.set(MaxW/2 - 3, MaxH/2+1, "BlocNT")

local y = 3

function Status(msg)
    BaseComponents.GPU.set(MaxW/2 - (#msg / 2), MaxH/2+y, msg)
    y = y + 1
end

Status("Start Graphics")
Graphics = Package.RequireG("Boot/Bootlibs/Graphics.lua")

Status("Start Kernel")
Kernel = Package.DoG("Krnl/Krnl.lua")

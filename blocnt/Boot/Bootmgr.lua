local handle = component.invoke(BootMount, "open", Boot.."Loadfile.lua")
local readed = component.invoke(BootMount, "read", handle, math.maxinteger or math.huge)
component.invoke(BootMount, "close", handle)

local func,err = load(readed, "="..Boot.."Loadfile.lua", "bt", _G)
func()

_G.Loadfile = select(2,pcall(func))

function BlackBG()
    component.invoke(gpu,"setBackground",0x000000)
    component.invoke(gpu,"setForeground",0xFFFFFF)
end

function WhiteBG()
    component.invoke(gpu,"setBackground",0xFFFFFF)
    component.invoke(gpu,"setForeground",0x000000)
end
WhiteBG()

component.invoke(gpu,"fill",1,1,TargetW,1," ")
component.invoke(gpu,"fill",1,TargetH,TargetW,1," ")
component.invoke(gpu,"set",30,1,"BlocOS Boot Loader")

function BootMGRError(string)
    BlackBG()
    component.invoke(gpu,"set",4,4,"Error: "..string)
    WhiteBG()
    component.invoke(gpu,"set",2,TargetH,"Any Key: Restart")
    halt()
end

-- TODO: BCD

local BootScript = Loadfile.Load("/Main/Sys/Boot/Boot.lua")

if BootScript == "NotFound" then
    BootMGRError("Couldnt find boot (/Main/Sys/Boot/Boot.lua)")
else
    BootScript()
end
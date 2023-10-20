-- We have a very basic API set up, so now time to finish booting
local sy = 6

component.invoke(component.list("gpu")(),"set",1,5,"Loading Components")
baseloading.loadandinit("base/components.lua")
_G.status = {}

function status(msg)
    component.gpu.set(1,sy,msg)
    sy = sy + 1
end

_G.package = _G.baseloading
_G.baseloading = nil

_G.signal = package.require("signal.lua")

shell = package.require("shell.lua")
shell.init()

while true do
    shell.render()
end
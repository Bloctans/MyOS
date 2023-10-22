-- We have a very basic API set up, so now time to finish booting
local sy = 6

component.invoke(component.list("gpu")(),"set",1,5,"Loading Components")
baseloading.loadandinit("base/components")
_G.status = {}

function status(msg)
    component.gpu.set(1,sy,msg)
    sy = sy + 1
end

status("Organizing globals")
_G.package = _G.baseloading
_G.require = package.require
_G.baseloading = nil

status("Initalizing Non base libs")
_G.strutil = require("strutil")
_G.signal = require("signal")

status("Starting shell...")
shell = require("shell")
shell.init()

while true do
    shell.render()
end
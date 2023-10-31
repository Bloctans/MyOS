-- We have a very basic API set up, so now time to finish booting
local sy = 8

component.invoke(component.list("gpu")(),"set",1,7,"Loading Components")
baseloading.loadandinit("base/components")
_G.status = {} -- idk why this is here

function status(msg)
    component.gpu.set(1,sy,msg)
    sy = sy + 1
end

status("Resetting GPU & Organizing globals")
local w,h = component.gpu.getResolution()
component.gpu.setResolution(w, h)
component.gpu.setBackground(0x000000)
component.gpu.setForeground(0xFFFFFF)

_G.package = _G.baseloading
_G.require = package.require
_G.baseloading = nil

status("Initalizing libs")
_G.strutil = require("strutil")
_G.signal = require("signal")

status("Starting shell...")
shell = require("shell")
shell.init()
status("Waiting for user input...")

while true do
    shell.render()
end
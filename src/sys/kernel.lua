-- Kernel, does non-wrapper related api inits and stuff

status("Initalizing libs")
_G.strutil = require("strutil")
_G.signal = require("signal")
_G.graphics = require("newapis/graphics")

status("Starting shell...")
shell = require("shell")
shell.init()
status("Waiting for user input...")

_G.graphicsmode = false

while true do
    if not graphicsmode then
        shell.render()
    else
        
    end
end
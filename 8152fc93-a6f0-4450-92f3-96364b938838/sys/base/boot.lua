--[[
    DONE:
        - Component API
        - require API
        - Base shell

    DO:
        - optimize base shell
        - better APIS (no more use of base apis)
        - error handling (for boot.lua in init.lua)

    TODO:  
        - Keyboard event wrapper
        - Main shell: Wrap around text once it hits the edge of screen
        - Main shell
]]

-- We have a very basic API set up, so now time to finish booting
local sy = 6

component.invoke(component.list("gpu")(),"set",1,5,"Loading Components")
baseloading.loadandinit("base/components.lua")
_G.status = {}

function status(msg)
    component.gpu.set(1,sy,msg)
    sy = sy + 1
end

local baseshell = baseloading.require("base/baseshell.lua")
baseshell.init()

while true do
    baseshell.render()
    local sig = {computer.pullSignal()}
    if sig[1] == "key_down" then
        baseshell.editline(baseshell.getline().."a")
    elseif sig[1] == "touch" then
        baseshell.newline()
    end
end
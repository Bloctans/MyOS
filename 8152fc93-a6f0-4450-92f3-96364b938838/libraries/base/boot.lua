--[[
    TODO:
        - Clear screen upon boot
        - Finish component API

    Later on:
        - Proper Main loop
        - Shell and stuff IDK
]]

boot = {}

boot.init = function()
    while true do
        computer.pullSignal()
    end
end

return boot
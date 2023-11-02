-- Core for the graphics mode (320 x 200)

graphics = {}

function graphics.start()
    _G.graphicsmode = true
end

function graphics.loop()
    -- Braille parse and stuff
end

function graphics.end()
    _G.graphicsmode = false
end

return graphics
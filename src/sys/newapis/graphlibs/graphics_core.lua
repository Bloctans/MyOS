-- Core for the graphics mode (320 x 200)

graphicsc = {}

function graphicsc.start()
    _G.graphicsmode = true
end

function graphicsc.loop()
    -- Braille parse and stuff
end

function graphicsc.stop()
    _G.graphicsmode = false
end

return graphicsc
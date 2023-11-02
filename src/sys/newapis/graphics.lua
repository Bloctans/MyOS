graphics = {}

function graphics.start()
    graphics_core.start()
end

function graphics.stop()

end

function graphics.drawpixel(x,y,color)
    graphics_core.stop()
end

return graphics
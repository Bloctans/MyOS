graphics = {}

graphics.draw = {}
graphics.accent = 0x000000

function graphics.drawpixel(x,y,bg,fg)
    local charx = math.floor(x / 2)
    local chary = math.floor(y / 4)
    local _x = x % 2
    local _y = y % 4

    if _x == 2 then local byte = math.pow((_y + 3) - 1,2)
    else local byte = math.pow(_y - 1,2) end

    if _y == 4 then
        byte = math.pow(5 + _x, 2)
    end

    if not graphics.draw[chary] then graphics.draw[chary] = {} end
    if not graphics.draw[chary][charx] then graphics.draw[chary][charx] = {} end

    if graphics.draw[chary][charx] then
        local binstring = graphics.draw[chary][charx][3]
    else
        local binstring = 0
    end

    binstring = bit32.bor(binstring, byte)

    graphics.draw[chary][charx] = {bg,fg,binstring}
end

function graphics.start(accent)
    _G.graphicsmode = true
    local w,h = component.gpu.getResolution()
    graphics.accent = accent
    component.gpu.setBackground(accent)
    component.gpu.fill(w,h,x,y," ")
    component.gpu.setBackground(0x000000)
end

function graphics.loop()
    -- Braille parse and stuff
    
end

function graphics.stop()
    _G.graphicsmode = false
end

return graphics
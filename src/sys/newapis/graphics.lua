graphics = {}

graphics.draw = {}
graphics.accent = 0x000000

function graphics.drawpixel(x,y,bg,fg)
    local charx = math.ceil(x / 2)
    local chary = math.ceil(y / 4)
    local _x = x % 3
    local _y = y % 5
    local binstring = 0
    local byte = 1

    if _x == 2 then byte = math.pow(2,(_y + 2))
    else byte = math.pow(2,_y-1) end

    if _y == 4 then
        byte = math.pow(2,5 + _x)
    end

    if not graphics.draw[chary] then graphics.draw[chary] = {} end

    if graphics.draw[chary][charx] then
        binstring = graphics.draw[chary][charx][3]
    end

    if not graphics.draw[chary][charx] then graphics.draw[chary][charx] = {} end

    binstring = byte | binstring

    graphics.draw[chary][charx] = {bg,fg,binstring}
end

function graphics.start(accent)
    _G.initgraphics = true
    local w,h = component.gpu.getResolution()
    graphics.accent = accent
    component.gpu.setBackground(accent)
    component.gpu.fill(w,h,0,0," ")
    component.gpu.setBackground(0x000000)
end

function graphics.render()
    -- Braille parse and stuff
    for i,v in pairs(graphics.draw) do
        for i2, v2 in pairs(graphics.draw[i]) do
            component.gpu.set(i2,i,unicode.char(10240 + v2[3]))
        end
    end
end

function graphics.stop()
    _G.initgraphics = false
end

return graphics
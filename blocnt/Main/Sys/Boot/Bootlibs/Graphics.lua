graphics = {}

graphics.draw = {}
graphics.accent = 0x000000

function graphics.drawpixel(x,y,fg,bg)
    local charx = math.ceil(x / 2)
    local chary = math.ceil(y / 4)
    local _x = ((x - 1) % 2) + 1
    local _y = ((y - 1) % 4) + 1
    local binstring = 0
    local cbyte = 1

    if _x == 2 then cbyte = math.pow(2,(_y + 2))
    else cbyte = math.pow(2,_y-1) end

    if _y == 4 then
        cbyte = math.pow(2,5 + _x)
    end

    if not graphics.draw[chary] then graphics.draw[chary] = {} end

    if graphics.draw[chary][charx] then
        binstring = graphics.draw[chary][charx][3]
    end

    if not graphics.draw[chary][charx] then graphics.draw[chary][charx] = {} end

    cbyte = math.floor(cbyte)
    binstring = cbyte | binstring

    graphics.draw[chary][charx] = {fg,bg,binstring}
end

function graphics.render()
    -- Braille parse and stuff
    for i,v in pairs(graphics.draw) do
        for i2, v2 in pairs(graphics.draw[i]) do
            BaseComponents.gpu.setForeground(v2[1])
            BaseComponents.gpu.setBackground(v2[2] or graphics.accent)
            BaseComponents.gpu.set(i2,i,unicode.char(10240 + v2[3]))
        end
    end
end

return graphics
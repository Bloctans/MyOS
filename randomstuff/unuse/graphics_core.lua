-- Core for the graphics mode (320 x 200)

graphicsc = {}

graphicsc.draw = {}

function graphicsc.drawpixel(x,y,color)
    local charx = math.floor(x / 2)
    local chary = math.floor(y / 4)
    local _x = x % 2
    local _y = y % 4
    if y == 4 then
        if x == 1 then local _byte = 7 else local _byte = 8 end
    else
        local _byte = (_y*_x)
    end

    graphicsc.draw[chary][charx][#graphicsc.draw[chary][charx] + 1] = {_byte,color}
end

function graphicsc.start(accent)
    _G.graphicsmode = true
    local w,h = component.gpu.getResolution()
    component.gpu.setBackground(accent)
    component.gpu.fill(w,h,x,y," ")
    component.gpu.setBackground(0x000000)
end

function graphicsc.loop()
    -- Braille parse and stuff
    for i,v in pairs(graphicsc.draw) do
        local x = v[1] % 2
        local y = v[2] % 4
        if y == 4 then
            y = 3
        end
        local charx = math.floor(v[1] / 2)
        local chary = math.floor(v[2] / 4)
        

        component.gpu(charx,chary, unicode.char(40 + (y*x)))
    end
end

function graphicsc.stop()
    _G.graphicsmode = false
end

return graphicsc
-- Kernel loop for easy error recovery

while true do
    type_,key = signal.get("key_down")
    if _G.initgraphics == false then
        shell.render(type_,key)
    else
        graphics.render()

        if type_ == "key_special" then
            if key == "enter" then
                component.gpu.setForeground(0xFFFFFF)
                component.gpu.setBackground(0x000000)
                graphics.stop()
            end
        end
    end
    --shell.render(type_,key)
end
-- Kernel loop for easy error recovery

while true do
    type_,key = signal.get("key_down")
    if _G.initgraphics == false then
        shell.render(type_,key)
    else
        graphics.render()
    end
    --shell.render(type_,key)
end
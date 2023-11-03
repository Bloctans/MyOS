-- Kernel loop for easy error recovery

while true do
    type_,key = signal.get("key_down")
    --[[if not graphicsmode then
        shell.render()
    else
        computer.pullSignal()
        graphics.loop()
    end]]
    shell.render(type_,key)
end
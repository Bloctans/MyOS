while true do
    local event, content = signal.get("key_down")
    if event == "key" then
        if content == "e" then
            break
        end
    end
end
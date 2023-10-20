signal = {}

function signal.pull()
    return {computer.pullSignal()}
end

keymap = {
    ["enter"] = 13
    ["back"] = 8
}

function signal.get(_type)
    local _signal = signal.pull()

    if _signal[1] == _type then
        if _type == "key_down" then
            -- TODO: move this to keyboard.lua
            if _signal[3] >= 32 then
                return "key", unicode.char(_signal[3])
            else
                for i,v in pairs(keymap) do
                    -- TODO: yeah
                end
            end
        end
    end
    return "none", nil
end

return signal
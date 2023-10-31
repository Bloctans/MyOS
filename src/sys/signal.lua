signal = {}

function signal.pull()
    return {computer.pullSignal()}
end

keyboard = require("keyboard")

function signal.get(_type)
    local _signal = signal.pull()

    if _signal[1] == _type then
        if _type == "key_down" then
            return keyboard.luasignal(_signal[3])
        end
    end
    return "none", nil
end

return signal
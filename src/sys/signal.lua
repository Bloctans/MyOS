signal = {}

function signal.pull(timeout)
    process.EventLoop() -- easy way to stop threads
    return {computer.pullSignal(timeout)}
end

keyboard = require("keyboard")

function signal.get(_type)
    local _signal = signal.pull(0.1)
    
    if _signal[1] == _type then
        if _type == "key_down" then
            return keyboard.luasignal(_signal[3])
        end
    end
    return "none", nil
end

return signal
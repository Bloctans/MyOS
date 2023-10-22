signal = {}

function signal.pull()
    return {computer.pullSignal()}
end

keyboard = require("keyboard")

types = {
    ["key_down"] = {keyboard.luasignal, 3}
}

function signal.get(_type)
    local _signal = signal.pull()

    if _signal[1] == _type then
        for i,v in pairs(types) do
            if i == _type then
                local use = types[_signal[1]]
                return use[1](_signal[use[2]])
            end
        end
    end
    return "none", nil
end

return signal
keyboard = {}

keymap = {
    ["enter"] = 13,
    ["back"] = 8
}

function keyboard.luasignal(sig)
    -- TODO: move this to keyboard.lua
    if sig >= 32 then
        return "key", unicode.char(sig)
    else
        for i,v in pairs(keymap) do
            if v == sig then
                return "key_special", i
            end
        end
    end
end

return keyboard
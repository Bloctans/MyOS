keyboard = {}

keymap = {
    ["enter"] = 28,
    ["back"] = 14,
    ["rctrl"] = 157
}

function keyboard.luasignal(sig,sig2)
    if sig >= 32 then
        return "key", unicode.char(sig)
    else
        for i,v in pairs(keymap) do
            if v == sig2 then
                return "key_special", i
            end
        end
    end
end

return keyboard
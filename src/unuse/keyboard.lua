keyboard = {}

-- TODO: make a interator for keymaps/ load keymaps
keymaps = {
    ["idtoan"] = package.require("keymaps/keymap_1.lua"),
    ["nametosym"] = package.require("keymaps/keymap_2.lua"),
    ["idtosym"] = package.require("keymaps/keymap_3.lua")
}

function keyboard.isTypable(id)
    for i,v in pairs(keymaps["idtoan"]) do
        
    end
    -- TODO: Symbols
end

return keyboard
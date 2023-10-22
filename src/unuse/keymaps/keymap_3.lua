-- Map values to symbols
local keyboard = {}

keyboard.apostrophe      = 0x28
keyboard.backslash       = 0x2B
keyboard.comma           = 0x33
keyboard.equals          = 0x0D
keyboard.lbracket        = 0x1A
keyboard.minus           = 0x0C
keyboard.period          = 0x34
keyboard.rbracket        = 0x1B
keyboard.semicolon       = 0x27
keyboard.slash           = 0x35 -- / on main keyboard
keyboard.space           = 0x39

-- Create inverse mapping for name lookup.
setmetatable(keyboard,
{
  __index = function(tbl, k)
    if type(k) ~= "number" then return end
    for name,value in pairs(tbl) do
      if value == k then
        return name
      end
    end
  end
})

return keyboard

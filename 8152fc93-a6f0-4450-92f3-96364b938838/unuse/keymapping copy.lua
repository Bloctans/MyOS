local keyboard = {}

keyboard.at              = 0x91
keyboard.back            = 0x0E -- backspace
keyboard.capital         = 0x3A -- capslock
keyboard.colon           = 0x92
keyboard.enter           = 0x1C
keyboard.grave           = 0x29 -- accent grave
keyboard.lcontrol        = 0x1D
keyboard.lmenu           = 0x38 -- left Alt
keyboard.lshift          = 0x2A
keyboard.numlock         = 0x45
keyboard.pause           = 0xC5
keyboard.rcontrol        = 0x9D
keyboard.rmenu           = 0xB8 -- right Alt
keyboard.rshift          = 0x36
keyboard.scroll          = 0x46 -- Scroll Lock
keyboard.stop            = 0x95
keyboard.tab             = 0x0F
keyboard.underline       = 0x93

-- Function keys
keyboard.f1              = 0x3B
keyboard.f2              = 0x3C
keyboard.f3              = 0x3D
keyboard.f4              = 0x3E
keyboard.f5              = 0x3F
keyboard.f6              = 0x40
keyboard.f7              = 0x41
keyboard.f8              = 0x42
keyboard.f9              = 0x43
keyboard.f10             = 0x44
keyboard.f11             = 0x57
keyboard.f12             = 0x58

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

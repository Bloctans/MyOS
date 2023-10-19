local keyboard = {}

keyboard["1"]           = 0x02
keyboard["2"]           = 0x03
keyboard["3"]           = 0x04
keyboard["4"]           = 0x05
keyboard["5"]           = 0x06
keyboard["6"]           = 0x07
keyboard["7"]           = 0x08
keyboard["8"]           = 0x09
keyboard["9"]           = 0x0A
keyboard["0"]           = 0x0B
keyboard.a               = 0x1E
keyboard.b               = 0x30
keyboard.c               = 0x2E
keyboard.d               = 0x20
keyboard.e               = 0x12
keyboard.f               = 0x21
keyboard.g               = 0x22
keyboard.h               = 0x23
keyboard.i               = 0x17
keyboard.j               = 0x24
keyboard.k               = 0x25
keyboard.l               = 0x26
keyboard.m               = 0x32
keyboard.n               = 0x31
keyboard.o               = 0x18
keyboard.p               = 0x19
keyboard.q               = 0x10
keyboard.r               = 0x13
keyboard.s               = 0x1F
keyboard.t               = 0x14
keyboard.u               = 0x16
keyboard.v               = 0x2F
keyboard.w               = 0x11
keyboard.x               = 0x2D
keyboard.y               = 0x15
keyboard.z               = 0x2C

keyboard.apostrophe      = 0x28
keyboard.at              = 0x91
keyboard.back            = 0x0E -- backspace
keyboard.backslash       = 0x2B
keyboard.capital         = 0x3A -- capslock
keyboard.colon           = 0x92
keyboard.comma           = 0x33
keyboard.enter           = 0x1C
keyboard.equals          = 0x0D
keyboard.grave           = 0x29 -- accent grave
keyboard.lbracket        = 0x1A
keyboard.lcontrol        = 0x1D
keyboard.lmenu           = 0x38 -- left Alt
keyboard.lshift          = 0x2A
keyboard.minus           = 0x0C
keyboard.numlock         = 0x45
keyboard.pause           = 0xC5
keyboard.period          = 0x34
keyboard.rbracket        = 0x1B
keyboard.rcontrol        = 0x9D
keyboard.rmenu           = 0xB8 -- right Alt
keyboard.rshift          = 0x36
keyboard.scroll          = 0x46 -- Scroll Lock
keyboard.semicolon       = 0x27
keyboard.slash           = 0x35 -- / on main keyboard
keyboard.space           = 0x39
keyboard.stop            = 0x95
keyboard.tab             = 0x0F
keyboard.underline       = 0x93

-- Keypad (and numpad with numlock off)
keyboard.up              = 0xC8
keyboard.down            = 0xD0
keyboard.left            = 0xCB
keyboard.right           = 0xCD
keyboard.home            = 0xC7
keyboard["end"]         = 0xCF
keyboard.pageUp          = 0xC9
keyboard.pageDown        = 0xD1
keyboard.insert          = 0xD2
keyboard.delete          = 0xD3

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

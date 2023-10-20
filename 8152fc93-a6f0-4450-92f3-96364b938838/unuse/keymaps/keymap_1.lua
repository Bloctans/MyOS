-- maps addresses to keys
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

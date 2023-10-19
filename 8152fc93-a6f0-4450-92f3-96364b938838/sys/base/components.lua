_G.components = {}
local componentsused = {"gpu","computer","keyboard"}
for _,v in pairs(componentsused) do
    _G.components[v] = component.proxy(component.list(v)())
end

_G.component = nil
_G.component = _G.components
_G.components = nil
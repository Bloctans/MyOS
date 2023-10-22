_G.components = {}
local componentsused = {"gpu","computer","keyboard","filesystem"}
for _,v in pairs(componentsused) do
    if v == "filesystem" then
        _G.components[v] = component.proxy(bootaddr)
    else
        _G.components[v] = component.proxy(component.list(v)())
    end
end

_G.component = nil
_G.component = _G.components
_G.components = nil
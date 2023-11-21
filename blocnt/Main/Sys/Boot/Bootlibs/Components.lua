Components = {}

function Components.Proxy(Name, List)
    local listed = component.list(Name)()
    return component.proxy(listed)
end

return Components
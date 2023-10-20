shell = {}

shell.current = "Type: "

function shell.init()
    shell.baseshell = package.require("base/baseshell.lua")

    shell.baseshell.new("Welcome to ".._G._OSVERSION)
    shell.baseshell.new("SysRoot: ".._G.ROOT.._G.SYSROOT)
    shell.baseshell.new("Running on ".._VERSION)
    shell.baseshell.edit(shell.current)
end

function shell.render()
    baseshell.render()
    type_,key = signal.get("key_down")
    if type_ == "key" then
        shell.current = shell.current..key
        shell.baseshell.edit(shell.current)
    elseif type_ == "key_enter" then
        shell.current = "Type: "
        shell.baseshell.new(shell.current)
    end
end

return shell
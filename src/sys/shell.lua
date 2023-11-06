shell = {}

runfile = require("runfile")

shell.runfilepath = "programs/"
shell.current = ""
shell.start = _G.ROOT.._G.SYSROOT.."programs> "

function shell.init()
    _G.baseshell = require("baseshell")

    baseshell.new("Welcome to ".._G._OSFULLV)
    baseshell.new("SysRoot: ".._G.ROOT.._G.SYSROOT)
    baseshell.new("Running on ".._VERSION)
    baseshell.new("Updating currently doesnt exist")
    baseshell.newlines()
end

function shell.handle_enter()
    local split = strutil.splitspace(shell.current)
    if shell.current ~= "" then
        runfile.run(shell.runfilepath..split[1])
    end

    shell.current = ""
    baseshell.newline()
end

function shell.render(type_,key)
    if type_ == "key" then
        shell.current = shell.current..key
    elseif type_ == "key_special" then
        if key == "enter" then
            shell.handle_enter()
        elseif key == "back" then
            shell.current = string.sub(shell.current, 1, #shell.current - 1)
        end
    end

    if type_ ~= "none" then
        baseshell.edit(shell.start..shell.current)
    end

    baseshell.render()
end

return shell
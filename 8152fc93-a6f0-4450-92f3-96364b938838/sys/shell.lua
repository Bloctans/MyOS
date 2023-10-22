shell = {}

runfile = require("runfile")

shell.runfilepath = "programs/"
shell.current = ""
shell.start = _G.ROOT.._G.SYSROOT.."programs> "

function shell.init()
    _G.baseshell = require("base/baseshell")

    baseshell.new("Welcome to ".._G._OSVERSION)
    baseshell.new("SysRoot: ".._G.ROOT.._G.SYSROOT)
    baseshell.new("Running on ".._VERSION)
    baseshell.new("Warning: This OS is pretty basic as of now.")
    baseshell.new("DO NOT PUT WHILE TRUE LOOPS IN YOUR PROGRAMS!")
    baseshell.newlines()
end

function shell.handle_enter()
    local split = strutil.splitspace(shell.current)
    if split[1] == "run" then
        if split[2] then
            runfile.run(shell.runfilepath..split[2])
        else
            baseshell.new("Input a file! (run dir to list)")
        end
    elseif split[1] == "help" or split[1] == "cmds" or split[1] == "commands" then
        baseshell.new("Help: ")
        baseshell.new(" run [file]: Run file")
        baseshell.new(" run dir: List programs")
        baseshell.new("  For now, in order to create/edit programs you need to")
        baseshell.new("  do that via external OS")
    elseif split[1] ~= "" then
        baseshell.new("Invalid Command: "..split[1])
    end
    
    shell.current = ""
    baseshell.newline()
end

function shell.render()
    baseshell.render()
    baseshell.edit(shell.start..shell.current)

    type_,key = signal.get("key_down")
    if type_ == "key" then
        shell.current = shell.current..key
    elseif type_ == "key_special" then
        if key == "enter" then
            shell.handle_enter()
        elseif key == "back" then
            shell.current = string.sub(shell.current, 1, #shell.current - 1)
        end
    end
end

return shell
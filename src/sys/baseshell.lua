-- the base shell sets up draw APIS and scrolling

shell_lines = {}

baseshell = {}

baseshell.currentline = 1

local w,h = component.gpu.getResolution()

local redrawshell = true -- If true, next render it will re draw the shell
local redrawlatest = false

function baseshell.render()
    if redrawshell then
        component.gpu.fill(1,1,w,h," ")
        for i,v in pairs(shell_lines) do
            component.gpu.set(1,i,v)
        end
        redrawshell = false
    end

    if redrawlatest then
        component.gpu.fill(1,baseshell.currentline,w,1," ")
        component.gpu.set(1,baseshell.currentline,shell_lines[baseshell.currentline])
        redrawlatest = false
    end
end

function baseshell.ext_redraw()
    redrawshell = true
end

function baseshell.remove()
    redrawshell = true
    if baseshell.currentline > 1 then
        baseshell.currentline = baseshell.currentline - 1
        table.remove(shell_lines,#shell_lines)
    end
end

function baseshell.clear()
    redrawshell = true
    baseshell.currentline = 0
    shell_lines = {}
end

function baseshell.new(msg)
    baseshell.newline() -- Enters a new line into the table
    baseshell.edit(msg) -- Sets the line to the msg
end

function baseshell.newlines(amount)
    if not amount then
        amount = 2
    end

    for i = 1,amount do
        baseshell.newline()
    end
end

function baseshell.newline()
    redrawshell = true
    shell_lines[#shell_lines + 1] = ""
    if #shell_lines > h then
        table.remove(shell_lines,1)
    else
        baseshell.currentline = baseshell.currentline + 1
    end
end

function baseshell.edit(msg)
    redrawlatest = true
    shell_lines[baseshell.currentline] = msg
end

function baseshell.get()
    return shell_lines[baseshell.currentline] or ""
end

return baseshell
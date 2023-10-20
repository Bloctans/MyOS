-- the base shell sets up draw APIS and scrolling

shell_lines = {}

baseshell = {}

baseshell.currentline = 1

local w,h = component.gpu.getResolution()
local redrawshell = true
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
    baseshell.newline()
    baseshell.edit(msg)
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
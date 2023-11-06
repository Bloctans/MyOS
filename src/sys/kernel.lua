-- Kernel, does non-wrapper related api inits and stuff

status("Initalizing libs")
_G.strutil = require("strutil")
_G.signal = require("signal")

--package.loadandinit("newapis/graphlibs/graphicsload")

status("Starting shell...")
shell = require("shell")
shell.init()

--_G.graphicsmode = false

function retry()
    function krnl_loop()
        package.loadandinit("kernel_loop")
    end

    local k_ok, k_err = xpcall(krnl_loop, debug.traceback)

    if not k_ok then
        if baseshell then -- in the rare case a base shell isnt detected, we don't want a level 2 error
            baseshell.ext_redraw()
        end
        component.gpu.set(0,1,"(Level 1 error)   ")
        component.gpu.set(0,2,"An error occured within the kernel loop.   ")
        component.gpu.set(0,3,"Enter to retry,   ")
        component.gpu.set(0,4,"V to View error,   ")
        component.gpu.set(0,5,"R to reboot.   ")
    end

    while true do
        local k_type,k_key = signal.get("key_down")

        if k_type == "key_special" then
            if k_key == "enter" then
                retry() -- idk how well this will work
            end
        elseif k_type == "key" then
            if k_key == "r" then computer.shutdown(true)
            elseif k_key == "v" then
                local _err = strutil.linebreaks(k_err,14)
                for i,v in pairs(_err) do component.gpu.set(0,i+6,v) end
            end
        end
    end
end
retry()
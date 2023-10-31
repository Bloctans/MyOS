--[[
    DONE:
        - Component API
        - require API
        - Base Shell (edit line, new line, render, get current line)
        - Base Shell: clear terminal
        - Base Shell: go back a line
        - Base Error Handler (for boot.lua in init.lua)
        - Keyboard API
        - Shell (init, render)
        - Shell: Enter to newline
        - Signals: move keyboard logic to lua script
        - Shell: Backspace
        - Run file: Error handler
        - Shell: run / Run file
        - Run file: cls
        - Run file: Error handler Details
        - Base Error Handler: fix strings
        - Run file: dir / List Current DIR
        - OpenOS: Installer Part 1
        - OpenOS: Installer Part 2 (Copy installer files)

    DOING:
        - Boot: Installer

    Alpha 1.0:  
        - GPU: setup res and fill at boot
        - Run file: Check for update
        - Run file: update

    Alpha 1.1 (Program and Graphics update):
        - Graphics mode 
            (draw pixels w/ braile) 
            (320 x 200 at 2 colors per 2x4 pixels)
            (look at far bottom of todo list for bit to braile)
        - Unhardcode current DIR
        - Run file: edit / Edit file
        - Run file: create / Create file
        - Run file: integrate into enter handle (instead of you having to do run [file])
        - Processes
        - Run file: CTRL + C

    Alpha 1.2 (Security and QOL Update):
        - Dir: paths
        - Dir: List file sizes and creation dates
        - Check for hard drive
        - Run file: Sandbox
        - Run file: Ability to either sandbox or unsandbox a program
        - Main shell: Wrap around text once it hits the edge of screen

    Alpha 1.3 (Rewrite and settings):
        - Run file: Config
        - Shell: cd / Change Current DIR
        - Base Shell: Optimize/Rewrite
        - Base Shell: keep last 4 lines in table
        - Rewrite all the bad things (currently only shell commands)
        - OS: User Management or somethin

    Alpha 1.4:
        - MineOS: Installer
        - API rewrites

    Maybe:
        - Code Comments
]]

--[[
    If you number each bit of a byte like 0b12345678 then a braille
    character looks like:

        8  5
        7  4
        6  3
        2  1
]]

--[[
    local ok, err = xpcall(main, debug.traceback)

    if not ok then
        printError(err)
    end

    traceback code
]]

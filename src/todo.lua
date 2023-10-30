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

    DOING:
        - Boot: Installer

    DO:
        - OpenOS: Installer Part 2 (Copy installer files)

    Alpha 1.0:  
        - GPU: setup res and fill at boot
        - MineOS: Installer
        - Run file: Check for update
        - Run file: update

    Alpha 1.1 (Program update):
        - Unhardcode current DIR
        - Run file: edit / Edit file
        - Run file: create / Create file
        - Dir: List file sizes and creation dates
        - Processes
        - Run file: CTRL + C
        - Check for hard drive

    Alpha 1.2:
        - Run file: Config
        - Dir: paths
        - Make Run integrated into enter handle (instead of you having to do run [file])
        - Run file: Sandbox
        - Run file: Ability to either sandbox or unsandbox a program
        - Main shell: Wrap around text once it hits the edge of screen

    Alpha 1.3:
        - Graphics mode (draw pixels)
        - Shell: cd / Change Current DIR
        - Base Shell: Optimize/Rewrite
        - Base Shell: keep last 4 lines in table
        - Rewrite all the bad things (currently only shell commands)
        - OS: User Management or somethin

    Alpha 1.4:
        - API rewrites

    Maybe:
        - Code Comments
]]

--[[
    local ok, err = xpcall(main, debug.traceback)

    if not ok then
        printError(err)
    end

    traceback code
]]

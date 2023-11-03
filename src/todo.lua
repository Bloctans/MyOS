--[[
    DONE:
        - System: Component API
        - System: require API
        - System: Base Shell (edit line, new line, render, get current line)
        - Base Shell: clear terminal
        - Base Shell: go back a line
        - Boot: Base Error Handler (for boot.lua in init.lua)
        - System: Keyboard API
        - Shell (init, render)
        - Shell: Enter to newline
        - Signals: move keyboard logic to lua script
        - Shell: Backspace
        - Run file: Error handler
        - Shell/System: Run files (run)
        - Run file: cls
        - Run file: Error handler Details
        - Base Error Handler: fix strings
        - Run file: dir / List Current DIR
        - OpenOS: Installer Part 1
        - OpenOS: Installer Part 2 (Copy installer files)
        - Boot: Installer
        - Boot: setup gpu res and fill
        - Run file: Check if exists
        - Run file: integrate into enter handle (instead of you having to do run [file])

    DOING:

    DO:
        - Start writing new InstallList
        - System: Processes
        - Run file: CTRL + C
        - Processes: Move run to a process
        - Processes: kernel (+shell mode) are considered process 0, the main thread
        - Processes: APIS
        - Signals: make it so that signal pulling works in the background and signal.get will ask for the latest input
        - Processes: Move graphics to a process
        - Signals: Move to a different process (thread) for better performance

    Alpha 1.0 (Done)

    Alpha 1.1 (Program and Graphics update):
        - Unhardcode current DIR
        - Run file: edit / Create/Edit file
        - Run file: rm / Remove File
        - Merge shell and baseshell with package.merge?
        - Blinking cursor
        
    Alpha 1.2 (Security and QOL Update):
        - Graphics mode 
            (draw pixels w/ braile) 
            (320 x 200 at 2 colors per 2x4 pixels)
            (look at far bottom of todo list for bit to braile)
        - Dir: paths
        - Dir: List file sizes and creation dates
        - Check for hard drive
        - Run file: Sandbox
        - Run file: Ability to either sandbox or unsandbox a program
        - Run file: List Processes
        - Shell: \n support
        - Run file: Args

    Alpha 1.3 (Rewrite and settings):
        - Run file: Config
        - Shell: cd / Change Current DIR
        - Base Shell: Optimize/Rewrite
        - Base Shell: keep last 4 lines in table
        - Rewrite all the bad things (currently only shell commands)
        - OS: User Management or somethin
        - Main shell: Wrap around text once it hits the edge of screen
        - Run file: update
        - Shell/System: Update check

    Alpha 1.4:
        - API rewrites (signal events)
        - Signals: Process multipile inputs
        - Shell: input lag (and keyboard)

    Alpha 1.5:
        - Feature: Graphical Shell Program (Windows 1.0 without 2 windows at once)
        - Run file: New process
        - Run file: End process
        - MineOS: Installer
]]

--[[
    Processes:
        The process system will start before the kernel. each process is a different thread.

        For sys:
            /programs/*: all run as a different process, can be stopped via CTRL+C
]]

--[[
    Braile characters: U+28XX

    to get pixel: modulus
    to get character: x/2, y/4, round down
    treat 1,4 and 2,4 specially, otherwise >3 = x: 2

    If you number each bit of a byte like 0b87654321 then a braille
    character looks like:
        1  4
        2  5
        3  6
        7  8

    how to store?
    we store each char x and y, then in that we have a fg color and a string with the binary in it
]]

--[[
    local ok, err = xpcall(main, debug.traceback)

    if not ok then
        printError(err)
    end

    traceback code
]]

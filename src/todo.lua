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
        - Program: Error handler
        - Shell/System: Run files (run)
        - Program: cls
        - Program: Error handler Details
        - Base Error Handler: fix strings
        - Program: dir / List Current DIR
        - OpenOS: Installer Part 1
        - OpenOS: Installer Part 2 (Copy installer files)
        - Boot: Installer
        - Boot: setup gpu res and fill
        - Program: Check if exists
        - Run file: integrate into enter handle (instead of you having to do run [file])
        - System: Processes
        - Processes: kernel (+shell mode) are considered process 1, the main thread
        - Processes: Move run to a process
        - Graphics mode (Practice for BlocNT)
            (draw pixels w/ braile) 
            (320 x 200 at 2 colors per 2x4 pixels)
            (look at far bottom of todo list for bit to braile)
        - Start writing new InstallList
]] 

--[[
    Roadmap:
        - Alpha 1.2 & 1.3
        - Continue blocnt
        - Alpha 1.4
]]

--[[
    
    DOING:

    DO:
        - 1.2: dev to new branch
        - Merge shell and baseshell with package.merge?
        - Blinking cursor    
        - Program: edit / Create/Edit file (Vim-Like)

    Alpha 1.0 (Done)

    Alpha 1.1 (Process and Graphics update) (Done)

    After 1.1: Start BlocNT (Done)

    Alpha 1.2:
        - Graphics mode: Premitive drawing system (From BlocNT if can)
        - Unhardcode current DIR
        - Program: rm / Remove File
        - Sleep function
        - Program: List Processes / Processes: List

    Alpha 1.3 (Security and QOL Update):
        - Dir: paths
        - Dir: List file sizes and creation dates
        - Check for hard drive
        - Wrapper lib for shell
        - Program: Sandbox programs
        - Shell: \n support
        - Program: Args

    Alpha 1.4 (Rewrite and settings):
        - Program: Config
        - Shell: cd / Change Current DIR
        - Base Shell: Optimize/Rewrite
        - Main shell: Wrap around text once it hits the edge of screen

    Alpha 1.5:
        - Require: New Require system for after kernel
        - API rewrites (signal, require)
        - Signals: Process multipile inputs
        - Shell: input lag (and keyboard)
        - Package: Move some things to fs
]]

--[[
    "BlocNT":
        https://en.wikipedia.org/wiki/Booting_process_of_Windows_NT
        Done:
            - Init
            - Boot: Boot manager
            - Boot: Basic Load File
            - BootLibs: packages
            - Boot: Overwrite BootMGRError at kernel time
            - Boot: Boot script
            - BootLibs: Graphics mode
            - BootLibs: Components

        Doing:     

        1.0:
            - Main: Sys
            - Windows 2.0

        1.1:
            - BCD
            - Boot Manager: Rewrite
            - Packager: Loaded cache

        Please, take your time and revise anything thats bad

        Layout:
            Init.lua: Finds the boot folder, Error Level 0 and initalizes bootmgr (tries to)
            Boot:
                BCD.lua: Stores the Data on where and what to boot (later)
                Bootmgr.lua: Allows you to choose what to boot
                LoadFile.lua: Shared between Main OS and Boot, ALLOW AN ENV TO BE PICKED (eg. _G)
            Main:
                Sys:
                    Config:
                        The registry, idk
                    Boot:
                        Boot.lua: Initalizes Bootlibs, then passes to kernel
                        BootLibs:
                            Package.lua: Handles all package systems for the os (Require, Run, Etc.)
                            Graphics.lua: The graphics system for the entire OS (320 x 200 at 2 colors per 2x4 pixels)
                            Components.lua: Basic Component proxy Wrapper, allows for components to be proxied. Component management comes later on in boot
                    Krnl:
                        KrnlLibs:
                            Keyboard.lua: API for typing and input (do this well please)
                            FS.lua: File system wrapper (also adds . and ..)
                            Process.lua: Processes
                        Krnl.lua: Error Level 1 (BSOD), and Initalizes KrnlLibs (Processes, Keyboard and stuff), Calls kmumb.lua after
                        kmumb.lua (Kernel-Mode User-Mode Boundry): Sets up kernel calls and the user mode Sandbox, Also sets up the kernel loop. initalizes user mode with umrt, considered the kernel by the process manager
                    Usermode:
                        UserLibs:
                            Cursor.lua: Mouse cursor and its API calls
                            WinMGR.lua: Window manager, also sandboxes windows so they can only use certain libs (listed in file)
                            GraphicsDraw.lua: Squares and stuff. Renames Graphics to GraphicsInternals and renames itself to Graphics
                            WinDraw.lua: Library for buttons and stuff to be drawn on a window
                        umrt.lua (User-mode runtime): Sets up apis for kernel calls (user side), Initalizes User-mode libs, and clears screen, Then calls uminit.lua
                        uminit.lua (User-mode init): Initalizes Desktop (Windows 2.0 pretty much)
]]

--[[
    Processes:
        The process system will start before the kernel. each process is a different thread.

        Data Layout for process:
            index 1: Status
            index 2: Name
            index 3: Other info
            index 4: coroutine object

    process.lua will be considered a process in the process list, however will not be endable
    to end, force an error!
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

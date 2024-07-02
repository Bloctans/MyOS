-- Giant list of files to install

install_list = {
    ["os"] = {
        ["/"] = {
            "init.lua",
            "osver.lua"
        },
        ["/sys/"] = {
            "baseshell.lua",
            "kernel.lua",
            "kernel_loop.lua",
            "keyboard.lua",
            "process.lua",
            "runfile.lua",
            "shell.lua",
            "signal.lua",
            "strutil.lua"
        },
        ["/sys/base/"] = {
            "baseloading.lua",
            "boot.lua",
            "components.lua"
        },
        ["/sys/programs/"] = {
            "cls.lua",
            "dir.lua",
            "endkrnl.lua",
            "error.lua",
            "gtest.lua",
            "help.lua",
            "reboot.lua",
            "shutdown.lua",
            "test.lua"
        }
    }
}

return install_list

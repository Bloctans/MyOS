-- Giant list of files to install

install_list = {
    ["os"] = {
        ["/"] = {
            "init.lua",
            "osver.lua"
        },
        ["/sys/"] = {
            "keyboard.lua",
            "runfile.lua",
            "runfile.lua",
            "shell.lua",
            "signal.lua",
            "strutil.lua"
        },
        ["/sys/base/"] = {
            "baseloading.lua",
            "baseshell.lua",
            "boot.lua",
            "components.lua"
        },
        ["/sys/programs/"] = {
            "cls.lua",
            "dir.lua",
            "reboot.lua",
            "shutdown.lua",
            "test.lua",
            "update.lua"
        }
    }
}

return install_list
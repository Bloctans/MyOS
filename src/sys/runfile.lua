runfile = {}

function runfile.run(path)
    if package.doesexist(path) then
        local ok, err = xpcall(package.loadandinit, debug.traceback, path)

        baseshell.newline()
        if not ok then
            baseshell.new("(Level 0 error)")
            baseshell.new("Error Running file")
            baseshell.new("Details:")

            local _err = strutil.linebreaks(err,6)
            for i,v in pairs(_err) do
                baseshell.new(v)
            end
        end
    else
        baseshell.new("Not a valid file! (Use dir for files you can run)")
    end
end

return runfile
runfile = {}

function runfile.run(path)
    local ok, err = xpcall(package.loadandinit, debug.traceback, path)

    baseshell.newline()
    if not ok then
        baseshell.new("Error Running file")
        baseshell.new("Details:")

        local _err = strutil.linebreaks(err,6)
        for i,v in pairs(_err) do
            baseshell.new(v)
        end
    else
        baseshell.new("Sucessfully ran file")
    end
end

return runfile
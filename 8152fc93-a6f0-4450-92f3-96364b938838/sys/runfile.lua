runfile = {}

function runfile.run(path)
    local ok, err = xpcall(package.loadandinit, debug.traceback, path)

    baseshell.newline()
    if not ok then
        baseshell.new("Error Running file")
    else
        baseshell.new("Sucessfully ran file")
    end
    baseshell.newline() -- weird behavior
end

return runfile
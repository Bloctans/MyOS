strutil = {}

function strutil.splitspace(str)
    local temp_table = {}

    for i in string.gmatch(str, "%S+") do
        temp_table[#temp_table + 1] = i
    end

    return temp_table
end

function strutil.linebreaks(str, max)
    local lines = {}

    if max then
        max = max - 1
    end
    local maxlines = 0

    for s2 in str:gmatch("[^\r\n]+") do
        maxlines = maxlines + 1
    end

    local linecount = 0

    for s in str:gmatch("[^\r\n]+") do
        linecount = linecount + 1
        new = ""
        for i = 1, #s do
            local c = s:sub(i,i)
            if c:byte() > 31 then
                new = new..c
            end
        end

        if max then
            if linecount < max then
                table.insert(lines, new)
            else
                if linecount == maxlines then
                    table.insert(lines, new)
                end
            end
        else
            table.insert(lines, new)
        end
    end

    return lines
end

return strutil
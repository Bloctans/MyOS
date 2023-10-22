strutil = {}

function strutil.splitspace(str)
    local temp_table = {}

    for i in string.gmatch(str, "%S+") do
        temp_table[#temp_table + 1] = i
    end

    return temp_table
end

return strutil
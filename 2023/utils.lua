function read_lines_from_file(filename)
    local lines = {}
    local file = io.open(filename, "r")

    for line in file:lines() do
        table.insert(lines, line)
    end
    file:close()
    return lines
end

function print_table(_table)
    print("{")
    for k, v in pairs(_table) do
        print("  " .. tostring(k) .. ": " .. tostring(v))
    end
    print("}")
end

return {
    read_lines_from_file = read_lines_from_file,
    print_table = print_table,
}

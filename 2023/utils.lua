function read_lines_from_file(filename)
    local lines = {}
    local file = io.open(filename, "r")

    for line in file:lines() do
        table.insert(lines, line)
    end
    file:close()
    return lines
end

return {
    read_lines_from_file = read_lines_from_file
}

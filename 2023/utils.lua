function read_lines_from_file(filename)
    local lines = {}
    local file = io.open(filename, "r")

    for line in file:lines() do
        table.insert(lines, line)
    end
    file:close()
    return lines
end

function print_table(tbl, indent)
    indent = indent or 1
    print(string.rep("  ", indent - 1) .. "{")
    for idx, value in pairs(tbl) do
        if type(value) == 'table' then
            value = print_table(value, indent + 1)
        else
            print(string.rep("  ", indent) .. tostring(idx) .. ": " .. tostring(value))
        end
    end
    print(string.rep("  ", indent - 1) .. "}")
end

function split(str)
    local res = {}
    for elem in str:gmatch("[^%s]+") do
        table.insert(res, elem)
    end
    return res
end

function sum(lst)
    local res = 0
    for _, num in pairs(lst) do
        res = res + num
    end
    return res
end

function map(tbl, fun)
    local res = {}
    for k, v in pairs(tbl) do
        res[k] = fun(v)
    end
    return res
end

function join(tbl, join_str)
    if join_str == nil then join_str = '' end
    local res = tbl[1]
    for i = 2, #tbl do
        res = res .. join_str .. tbl[i]
    end
    return res
end

return {
    read_lines_from_file = read_lines_from_file,
    print_table = print_table,
    split = split,
    sum = sum,
    map = map,
    join = join,
}

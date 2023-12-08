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
    print("{")
    for key, value in pairs(tbl) do
        if type(value) == 'table' then
            io.write(string.rep("  ", indent) .. tostring(key) .. ": ")
            print_table(value, indent + 1)
        else
            io.write(string.rep("  ", indent) .. tostring(key) .. ": " .. tostring(value) .. ",\n")
        end
    end
    local comma = (indent > 1) and "," or ""
    print(string.rep("  ", indent - 1) .. "}" .. comma .. "")
end

function split(str, splitter)
    local res = {}
    if splitter ~= nil then
        for elem in str:gmatch("[^" .. splitter .. "]+") do
            table.insert(res, elem)
        end
    else
        for chr in str:gmatch('%w') do
            table.insert(res, chr)
        end
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

function max(tbl, key_to_exclude)
    local max = nil
    local max_index = nil
    for key, val in pairs(tbl) do
        if (max == nil or val > max) and key ~= key_to_exclude then
            max = val
            max_key = key
        end
    end
    return max, max_key
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

function len(tbl)
    local res = 0
    for _, _ in pairs(tbl) do res = res + 1 end
    return res
end

function all(tbl, fun)
    local res = true
    for key, val in pairs(tbl) do
        res = res and fun(key, val)
    end
    return res
end

function gcd(a, b)
	return b==0 and a or gcd(b,a%b)
end

return {
    read_lines_from_file = read_lines_from_file,
    print_table = print_table,
    split = split,
    sum = sum,
    max = max,
    map = map,
    join = join,
    len = len,
    all = all,
    gcd = gcd,
}

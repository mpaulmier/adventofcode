local utils = require("utils")

local function compute_line(line)
    local first = nil
    local last = nil
    for i = 1, #line do
        local chr = line:sub(i, i)
        number = tonumber(chr, 10)
        if number then
            first = first or chr
            last = chr
        end
    end
    return tonumber(first .. last)
end

function part1(lines)
    local total = 0
    for _, line in ipairs(lines) do
        total = total + compute_line(line)
    end
    return total
end

local STR_TO_DIGITS = {
    one = 1,
    two = 2,
    three = 3,
    four = 4,
    five = 5,
    six = 6,
    seven = 7,
    eight = 8,
    nine = 9,
}

function part2(lines)
    local total = 0
    for _, line in ipairs(lines) do
        local new_line = ""
        for i = 1, #line do
            sub_line = line:sub(i, #line)
            for k, v in pairs(STR_TO_DIGITS) do
                new_sub_line = sub_line:gsub("^"..k, v)
                if new_sub_line ~= sub_line then
                    pt_add = #k
                    break
                end
            end
            new_line = new_line .. new_sub_line:sub(1, 1)
        end
        total = total + compute_line(new_line)
    end
    return total
end

local lines = utils.read_lines_from_file("inputs/day1.txt")
print("Part 1: " .. part1(lines))
print("Part 2: " .. part2(lines))

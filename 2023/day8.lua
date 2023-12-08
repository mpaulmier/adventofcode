local utils = require("utils")

GOAL = "ZZZ"

function get_elems(lines)
    local elems = {}
    local starts = {}
    for i = 3, #lines do
        local line = lines[i]
        local key = line:sub(1, 3)
        if key:sub(3) == "A" then table.insert(starts, key) end
        local left = line:sub(8, 10)
        local right = line:sub(13, 15)
        local elem = {}
        elems[key] = {
            L = left,
            R = right,
        }
        table.insert(elems, elem)
    end
    return elems, starts
end

function part1(elems, first, goal_func)
    local steps = 0
    local current = first
    while not goal_func(current) do
        steps = steps + 1
        local idx = math.fmod(steps, #SEQUENCE)
        if idx == 0 then idx = #SEQUENCE end
        local move = SEQUENCE[idx]
        current = elems[current][move]
    end
    return steps
end

function part2(elems, starts)
    local results = {}
    local goal_func = function(x) return x:sub(3) == "Z" end
    for _, start in ipairs(starts) do
        local res = part1(elems, start, goal_func)
        table.insert(results, res)
    end
    -- Now find the lowest common mutliple of all these results
    local a, b = results[1], nil
    for i = 2, #results do
        b = results[i]
        local lcm = math.floor(a * b / utils.gcd(a, b))
        a = lcm
    end
    return a
end

local lines = utils.read_lines_from_file("inputs/day8.txt")
local elems, starts = get_elems(lines)
SEQUENCE = utils.split(lines[1])
print("Part 1: " .. part1(elems, "AAA", function(x) return x == "ZZZ" end))
print("Part 2: " .. part2(elems, starts))

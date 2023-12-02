local utils = require("utils")

local function is_possible(game, colors)
    local possible = true
    local game_draws = game:sub(game:find(":") + 1)
    for draw in game_draws:gmatch("[^;]+") do
        for num_str, color in draw:gmatch("(%d+) (%w+)") do
            local num = tonumber(num_str)
            possible = possible and (colors[color] >= num)
        end
    end
    return possible
end

function part1(lines)
    local total = 0
    local colors = {
        red = 12,
        green = 13,
        blue = 14,
    }
    for id, game in ipairs(lines) do
        if is_possible(game, colors) then
            total = total + id
        end
    end
    return total
end

local function min_power(game)
    local mins = {
        red = -1,
        green = -1,
        blue = -1,
    }
    local game_draws = game:sub(game:find(":") + 1)
    for draw in game_draws:gmatch("[^;]+") do
        for num_str, color in draw:gmatch("(%d+) (%w+)") do
            local num = tonumber(num_str)
            mins[color] = math.max(num, mins[color])
        end
    end
    return mins.red * mins.green * mins.blue
end

function part2(lines)
    local total = 0
    for _, game in ipairs(lines) do
        total = total + min_power(game)
    end
    return total
end

local lines = utils.read_lines_from_file("inputs/day2.txt")
print("Part 1: " .. part1(lines))
print("Part 2: " .. part2(lines))

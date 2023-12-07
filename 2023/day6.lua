local utils = require("utils")

function get_times(lines)
    return utils.split(lines[1]:sub(lines[1]:find(":") + 1), "%s")
end

function get_dists(lines)
    return utils.split(lines[2]:sub(lines[2]:find(":") + 1), "%s")
end

function get_part1_input(lines)
    local times = utils.map(get_times(lines), tonumber)
    local dists = utils.map(get_dists(lines), tonumber)
    return times, dists
end

function solve(time, dist)
    local min, max = nil, nil

    function compute(held)
        local remaining = time - held
        local mm = remaining * held
        return mm
    end

    for time_held = 1, time do
        if min == nil then
            if compute(time_held) > dist then
                min = time_held
            end
        end
        if max == nil then
            time_held = time - time_held
            if compute(time_held) > dist then
                max = time_held
            end
        end
        if min ~= nil and max ~= nil then break end
    end
    return max - min + 1
end

function part1(lines)
    local res = 1
    local times, dists = get_part1_input(lines)
    for i = 1, #times do
        local time, dist = table.unpack {times[i], dists[i]}
        res = res * solve(time, dist)
    end
    return res
end

function get_part2_input(lines)
    local time_chunks = get_times(lines)
    local dist_chunks = get_dists(lines)
    local time = tonumber(utils.join(time_chunks))
    local dist = tonumber(utils.join(dist_chunks))
    return time, dist
end

function part2(lines)
    local time, dist = get_part2_input(lines)
    return solve(time, dist)
end

local lines = utils.read_lines_from_file("inputs/day6.txt")
print("Part 1: " .. part1(lines))
print("Part 2: " .. part2(lines))

local utils = require("utils")

local function get_seeds(line)
    local start = line:find(":") + 1
    local seeds = {}
    for seed in line:sub(start):gmatch("[^%s]+") do
        table.insert(seeds, tonumber(seed))
    end
    return seeds
end

local function get_range(lines, start)
    local idx = start
    local ranges = {}
    while lines[idx] ~= nil and lines[idx] ~= "" do
        local range = {}
        local line = lines[idx]
        local dst_start, src_start, len = table.unpack(
            utils.map(utils.split(line), tonumber))
        range.start = src_start
        range._end = src_start + len - 1
        range.diff = dst_start - src_start
        table.insert(ranges, range)
        idx = idx + 1
    end
    return idx + 2, ranges
end

local function get_location_from_seed(seed, maps)
    local res = seed
    for idx = 1, 7 do
        local ranges = maps[idx]
        for _, range in ipairs(ranges) do
            if res >= range.start and res <= range._end then
                res = res + range.diff
                break
            end
        end
    end
    return res
end

local function get_maps(lines)
    local maps = {}
    local _next = 4
    for idx = 1, 7 do
        _next, new_ranges = get_range(lines, _next)
        table.insert(maps, new_ranges)
    end
    return maps
end

function part1(lines)
    local locations = {}
    local maps = get_maps(lines)
    local seeds = get_seeds(lines[1])
    for _, seed in ipairs(seeds) do
        table.insert(locations, get_location_from_seed(seed, maps))
    end
    return math.min(table.unpack(locations))
end

-- TODO: Fix day 5 part 2

-- This is the brute force solution, I havent run it all the way through because
-- I care about the planet! Find a better solution for day 5 by collapsing
-- ranges together
function part2(lines)
    local locations = {}
    local maps = get_maps(lines)
    local seeds = get_seeds(lines[1])
    local seed_pairs = {}
    for idx = 1, #seeds, 2 do
        local pair = {}
        table.insert(pair, seeds[idx])
        table.insert(pair, seeds[idx + 1])
        table.insert(seed_pairs, pair)
    end
    for _, pair in ipairs(seed_pairs) do
        for seed = pair[1], pair[1] + pair[2] - 1 do
            table.insert(locations, get_location_from_seed(seed, maps))
        end
    end
    return math.min(table.unpack(locations))
end

local lines = utils.read_lines_from_file("inputs/day5.txt")
print("Part 1: " .. part1(lines))
print("Part 2: " .. part2(lines))

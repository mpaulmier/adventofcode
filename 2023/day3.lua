local utils = require("utils")

SYM_REGEX = "[^.%d]"

function part1(lines)
    local total = 0
    for linum, line in ipairs(lines) do
        while line ~= nil do
            local start, _end = line:find("%d+")
            if start == nil then break end
            local number = tonumber(line:sub(start, _end))
            local function update_maybe(sub_line)
                if sub_line:find(SYM_REGEX) then
                    total = total + number
                    return true
                end
                return false
            end
            sub_start = math.max(start - 1, 1)
            sub_end = math.min(_end + 1, line:len())
            if update_maybe(line:sub(sub_start, sub_end)) then goto continue end
            if linum > 1 then
                local prev = lines[linum - 1]
                prev = prev:sub(prev:len() - line:len() + 1)
                if update_maybe(prev:sub(sub_start, sub_end)) then goto continue end
            end
            if linum < #lines then
                local next_ = lines[linum + 1]
                next_ = next_:sub(next_:len() - line:len() + 1)
                if update_maybe(next_:sub(sub_start, sub_end)) then goto continue end
            end
            ::continue::
            line = line:sub(_end + 1)
        end
    end
    return total
end

function get_adjacents(sub_line, pos)
    local adjacents = {}
    local lstart = 1
    local sub_start = math.max(pos - 3, 1)
    local sub_end = math.min(pos + 3, sub_line:len())
    -- Gimme gfind :'(
    while lstart <= sub_end do
        start, _end = sub_line:sub(lstart):find("%d+")
        if start == nil then break end
        if math.abs((start + lstart -1) - pos) <= 1 or math.abs((_end + lstart - 1) - pos) <= 1 then
            num = tonumber(sub_line:sub(lstart):sub(start, _end))
            table.insert(adjacents, num)
        end
        lstart = lstart + _end + 1
    end
    return adjacents
end

function part2(lines)
    -- This solutions takes advantage of the fact that I know there are only 3
    -- digit part numbers at most. I don't think it is said in the problem
    -- statement but I assume it is the rule.
    local total = 0
    for linum, line in ipairs(lines) do
        while line ~= nil do
            local start = line:find("%*")
            if start == nil then break end
            local adjacents = {}
            for _, adj in ipairs(get_adjacents(line, start)) do
                table.insert(adjacents, adj)
            end
            if linum > 1 then
                local prev = lines[linum - 1]
                prev = prev:sub(prev:len() - line:len() + 1)
                for _, adj in ipairs(get_adjacents(prev, start)) do
                    table.insert(adjacents, adj)
                end
            end
            if linum < #lines then
                local next_ = lines[linum + 1]
                next_ = next_:sub(next_:len() - line:len() + 1)
                for _, adj in ipairs(get_adjacents(next_, start)) do
                    table.insert(adjacents, adj)
                end
            end
            if #adjacents == 2 then
                total = total + (adjacents[1] * adjacents[2])
            end
            line = line:sub(start + 1)
        end
    end
    return total
end

local lines = utils.read_lines_from_file("inputs/day3.txt")
print("Part 1: " .. part1(lines))
print("Part 2: " .. part2(lines))

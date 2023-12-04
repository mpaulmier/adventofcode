local utils = require("utils")

function line_winnings(line)
    local nb_winnings = 0
    local winners = {}
    local winners_str = line:sub(line:find(":") + 1, line:find("|") - 1)
    local scratched_str = line:sub(line:find("|") + 1)
    for winner in winners_str:gmatch("[^%s]+") do
        winners[winner] = true
    end
    for scratched in scratched_str:gmatch("%d+") do
        if winners[scratched] then
            nb_winnings = nb_winnings + 1
        end
    end
    return nb_winnings
end

function part1(lines)
    local total = 0
    for _, line in ipairs(lines) do
        local nb_winnings = line_winnings(line)
        if nb_winnings > 0 then
            total = total + math.pow(2, nb_winnings - 1)
        end
    end
    return total
end

function get_copies(linum, line)
    local copies = {}
    local nb_winnings = line_winnings(line)
    for i = linum + 1, linum + nb_winnings do
        table.insert(copies, i)
    end
    return copies
end

function part2(lines)
    local scratchcards = {}
    for i = 1, #lines do scratchcards[i] = 1 end
    for i, line in ipairs(lines) do
        local nb_copies = scratchcards[i]
        local copies = get_copies(i, line)
        for _, copy in ipairs(copies) do
            scratchcards[copy] = scratchcards[copy] + 1 * nb_copies
        end
    end
    local total = 0
    for _, nb_copies in pairs(scratchcards) do
        total = total + nb_copies
    end
    return total
end

local lines = utils.read_lines_from_file("inputs/day4.txt")
print("Part 1: " .. part1(lines))
print("Part 2: " .. part2(lines))

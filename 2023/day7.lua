local utils = require("utils")

POINTS1 = {
    ["A"] = 12,
    ["K"] = 11,
    ["Q"] = 10,
    ["J"] = 9,
    ["T"] = 8,
    ["9"] = 7,
    ["8"] = 6,
    ["7"] = 5,
    ["6"] = 4,
    ["5"] = 3,
    ["4"] = 2,
    ["3"] = 1,
    ["2"] = 0,
}

POINTS2 = {
    ["A"] = 12,
    ["K"] = 11,
    ["Q"] = 10,
    ["T"] = 9,
    ["9"] = 8,
    ["8"] = 7,
    ["7"] = 6,
    ["6"] = 5,
    ["5"] = 4,
    ["4"] = 3,
    ["3"] = 2,
    ["2"] = 1,
    ["J"] = 0,
}

function cmp_part1(left, right)
    local lc = left.combos
    local rc = right.combos
    local max_l, max_lk = utils.max(lc)
    local max_r, max_rk = utils.max(rc)
    -- For checking full houses
    local second_max_l = utils.max(lc, max_lk)
    local second_max_r = utils.max(rc, max_rk)
    if max_l ~= max_r then
        return max_l > max_r
    elseif second_max_l ~= second_max_r then
        return second_max_l > second_max_r
    else
        for i = 1, 5 do
            local card_r = right.hand[i]
            local card_l = left.hand[i]
            if POINTS1[card_l] ~= POINTS1[card_r] then
                return POINTS1[card_l] > POINTS1[card_r]
            end
        end
    end
end

function part1(lines, cmp)
    cmp = cmp or cmp_part1
    local all_hands = {}
    for _, line in pairs(lines) do
        local hand, bid = table.unpack(utils.split(line, "%s"))
        -- Terrible naming
        local combos = {}
        hand = utils.split(hand)
        for _, card in pairs(hand) do
            combos[card] = combos[card] and combos[card] + 1 or 1
        end
        bid = tonumber(bid)
        table.insert(all_hands, {
                hand = hand,
                combos = combos,
                bid = bid,
        })
    end
    table.sort(all_hands, cmp)
    local winnings = 0
    for i = 0, #all_hands - 1 do
        local hand = all_hands[#all_hands - i]
        local bid = hand.bid
        winnings = winnings + bid * (i + 1)
    end
    return winnings
end

function cmp_part_2(left, right)
    local lc = left.combos
    local rc = right.combos
    local max_l, max_lk = utils.max(lc, "J")
    if lc.J ~= nil then max_l = (max_l or 0) + lc.J end
    local max_r, max_rk = utils.max(rc, "J")
    if rc.J ~= nil then max_r = (max_r or 0) + rc.J end
    -- For checking full houses
    local second_max_l, k = utils.max(lc, max_lk)
    if k == "J" then second_max_l = 1 end
    second_max_l = second_max_l or 0
    local second_max_r, k = utils.max(rc, max_rk)
    if k == "J" then second_max_r = 1 end
    second_max_r = second_max_r or 0
    if max_l ~= max_r then
        return max_l > max_r
    elseif second_max_l ~= second_max_r then
        return second_max_l > second_max_r
    else
        for i = 1, 5 do
            local card_r = right.hand[i]
            local card_l = left.hand[i]
            if POINTS2[card_l] ~= POINTS2[card_r] then
                return POINTS2[card_l] > POINTS2[card_r]
            end
        end
    end
end

function part2(lines)
    return part1(lines, cmp_part_2)
end

local lines = utils.read_lines_from_file("inputs/day7.txt")
print("Part 1: " .. part1(lines))
print("Part 2: " .. part2(lines))

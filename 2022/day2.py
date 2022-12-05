by_outcome = {
    'A X': 3,
    'A Y': 4,
    'A Z': 8,
    'B X': 1,
    'B Y': 5,
    'B Z': 9,
    'C X': 2,
    'C Y': 6,
    'C Z': 7,
}

by_hand = {
    'A X': 4,
    'A Y': 8,
    'A Z': 3,
    'B X': 1,
    'B Y': 5,
    'B Z': 9,
    'C X': 7,
    'C Y': 2,
    'C Z': 6,
}


def compute_score(round: str) -> int:
    return by_hand[round]


def part1(inpt: str) -> int:
    return sum(map(compute_score, inpt.strip().split('\n')))


def choose_outcome(round: str) -> int:
    return by_outcome[round]


def part2(inpt: str) -> int:
    return sum(map(choose_outcome, inpt.strip().split('\n')))


def main() -> None:
    with open('inputs/2', 'r') as f:
        content = f.read()
        print(f'Part 1: {part1(content)}')
        print(f'Part 2: {part2(content)}')


if __name__ == '__main__':
    main()

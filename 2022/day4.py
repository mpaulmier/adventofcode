from typing import Callable


def contains_all(range_1: str, range_2: str) -> bool:
    min_1, max_1 = map(int, range_1.split('-'))
    min_2, max_2 = map(int, range_2.split('-'))
    return ((min_1 >= min_2 and max_1 <= max_2) or
            (min_2 >= min_1 and max_2 <= max_1))


def contains_some(range_1: str, range_2: str) -> bool:
    min_1, max_1 = map(int, range_1.split('-'))
    min_2, max_2 = map(int, range_2.split('-'))
    return min_1 in range(min_2, max_2 + 1) or min_2 in range(min_1, max_1 + 1)


def does_contain(line: str, func: Callable[[str, str], bool]) -> bool:
    if line == '':
        return False
    return func(*line.split(','))


def part1(inpt: str) -> int:
    return len([x for x in inpt.split('\n') if does_contain(x, contains_all)])


def part2(inpt: str) -> int:
    return len([x for x in inpt.split('\n') if does_contain(x, contains_some)])


def main() -> None:
    with open('inputs/4', 'r') as f:
        content = f.read()
        print(f'Part 1: {part1(content)}')
        print(f'Part 2: {part2(content)}')


if __name__ == '__main__':
    main()

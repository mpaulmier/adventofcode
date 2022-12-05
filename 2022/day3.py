def priority(c: str) -> int:
    is_upper = c.upper() == c
    return ord(c.lower()) - ord('a') + 1 + (26 if is_upper else 0)


def compute_priorities(line: str) -> int:
    length = len(line)
    first, second = (line[:length//2], line[length//2:])
    priority_sum = sum(list(map(priority, {x for x in first if x in second})))
    return priority_sum


def part1(inpt: str) -> int:
    return sum(map(compute_priorities, inpt.split('\n')))


def group_type(group: list) -> int:
    type = next(x for x in group[0] if all(x in g for g in group))
    return priority(type)


def part2(inpt: str) -> int:
    bags = inpt.split('\n')
    grouped = []
    for i in range(0, len(bags), 3):
        grouped.append(bags[i:i+3])
    return sum(map(group_type, grouped))


def main() -> None:
    with open('inputs/3', 'r') as f:
        content = f.read()
        print(f'Part 1: {part1(content)}')
        print(f'Part 2: {part2(content)}')


if __name__ == '__main__':
    main()

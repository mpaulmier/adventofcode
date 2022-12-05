def count_calories(inpt: str) -> map:
    def elf_calories(items: str) -> int:
        if items == '':
            return 0
        return sum(map(int, items.strip().split('\n')))

    return map(elf_calories, inpt.split('\n\n'))


def part1(inpt: str) -> int:
    return max(count_calories(inpt))


def part2(inpt: str) -> list[int]:
    return sum([x for x, _ in zip(sorted(count_calories(inpt), reverse=True),
                                  range(3))])


def main() -> None:
    with open('inputs/1', 'r') as f:
        content = f.read()
        print(f'Part 1: {part1(content)}')
        print(f'Part 2: {part2(content)}')


if __name__ == '__main__':
    main()

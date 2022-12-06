from typing import List, Optional


def parse_head(head: str) -> List[List[str]]:
    lines = head.split('\n')
    stacks: List[List[str]] = [[] for _ in range(9)]
    for line in lines[:-1]:
        for idx, char in enumerate(line):
            if char.isalpha():
                try:
                    stack_idx = int(lines[-1][idx]) - 1
                    stacks[stack_idx].append(char)
                except IndexError:
                    breakpoint()
    return stacks


def solve(inpt: str, revert: Optional[bool] = False) -> str:
    head, instructions = inpt.split('\n\n')
    stacks = parse_head(head)
    for instruction in instructions.split('\n'):
        if instruction == '':
            continue
        _, n, _, f, _, t = instruction.split(' ')
        num = int(n)
        from_, to = map(lambda x: int(x) - 1, (f, t))
        take = stacks[from_][:num]
        if revert:
            take = take[::-1]
        stacks[from_] = stacks[from_][num:]
        stacks[to] = take + stacks[to]
    return ''.join(x[0] if x else '' for x in stacks)


def main() -> None:
    with open('inputs/5', 'r') as f:
        content = f.read()
        print(f'Part 1: {solve(content, revert=True)}')
        print(f'Part 2: {solve(content)}')


if __name__ == '__main__':
    main()

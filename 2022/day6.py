from typing import List


def solve(inpt: str, start_len: int) -> int:
    letters: List[str] = []
    for idx, c in enumerate(inpt.strip()):
        if len(letters) < start_len:
            letters.append(c)
            continue
        if len(set(letters)) == len(letters):
            break
        else:
            letters = letters[1:] + [c]
    return idx


def main() -> None:
    with open('inputs/6', 'r') as f:
        content = f.read()
        print(f'Part 1: {solve(content, 4)}')
        print(f'Part 2: {solve(content, 14)}')


if __name__ == '__main__':
    main()

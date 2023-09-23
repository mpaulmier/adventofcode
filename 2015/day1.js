const fs = require("fs");

const part1 = input => input
      .split('')
      .reduce((acc, bracket) => {
        return acc + (bracket === '(' ? 1 : -1)
      }, 0)

const part2 = input => {
  let floor = 0
  const inputArr = input.split('')
  for (let idx = 0; idx < inputArr.length; idx++) {
    floor += (inputArr[idx] === '(' ? 1 : -1)
    if (floor === -1) {
      return idx + 1
    }
  }
}

const input = fs.readFileSync("inputs/day1.txt", { encoding: "utf-8" }).trim()
console.log(`Part 1: ${part1(input)}`)
console.log(`Part 2: ${part2(input)}`)

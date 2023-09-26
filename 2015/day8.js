const fs = require("fs");

const part1 = input => input
      .split("\n")
      .map(line => line.length - eval(`${line}`).length)
      .reduce((acc, el) => acc + el, 0)



const part2 = input => input
      .split("\n")
      .map(line => JSON.stringify(line).length - line.length)
      .reduce((acc, el) => acc + el)

const input = fs.readFileSync("inputs/day8.txt", { encoding: "utf-8" }).trim()
console.log(`Part 1: ${part1(input)}`)
console.log(`Part 2: ${part2(input)}`)

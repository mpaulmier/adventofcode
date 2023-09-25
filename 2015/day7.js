const fs = require('fs')

const parseInput = (input) => {
  const wires = {}
  input
    .split('\n')
    .forEach((el) => {
      let [_, left, op, right, recipient] = el.match(/^(?:([a-z\d]+) )?(?:([A-Z]+) )?([a-z\d]+) -> ([a-z]+)$/)
      if (!isNaN(left)) left = +left
      if (!isNaN(right)) right = +right
      wires[recipient] = [left, op, right]
    })
  return wires

}

const solveWire = (left, op, right, solved) => {
  if (typeof left === "string") {
    if (left in solved) left = solved[left];
    else return null;
  }

  if (typeof right === "string") {
    if (right in solved) right = solved[right];
    else return null;
  }

  switch (op) {
  case "NOT": return 0xffff - right;
  case "AND": return left & right;
  case "OR": return left | right;
  case "LSHIFT": return left << right;
  case "RSHIFT": return left >> right;
  }

  return right
}

const part1 = (input) => {
  const wires = parseInput(input)
  let solved = {}
  while (solved['a'] === undefined) {
    for (const key in wires) {
      if (key in solved) continue
      let val = solveWire(...wires[key], solved)
      if (val !== null) {
        solved[key] = val
      }
    }
  }
  return solved['a']
}

const part2 = (input) => {
  const wires = parseInput(input)
  let solved = {}
  solved['b'] = part1(input)
  while (solved['a'] === undefined) {
    for (const key in wires) {
      if (key in solved) continue
      let val = solveWire(...wires[key], solved)
      if (val !== null) {
        solved[key] = val
      }
    }
  }
  return solved['a']
}

const input = fs.readFileSync('inputs/day7.txt', {'encoding': 'utf8'}).trim()
console.log(`Part 1: ${part1(input)}`)
console.log(`Part 2: ${part2(input)}`)

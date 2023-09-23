const fs = require('fs')

const part1 = (input) => {
  let current = [0, 0]
  let houses = new Set()
  houses.add('0,0')
  for (let dir of input.split('')) {
    switch (dir) {
    case '>':
      current[1] += 1
      break;
    case '<':
      current[1] -= 1
      break
    case '^':
      current[0] += 1
      break
    case 'v':
      current[0] -= 1
      break
    }
    houses.add(`${current[0]},${current[1]}`)
  }
  return houses.size
}

const part2 = (input) => {
  let currentSanta = [0, 0]
  let currentRobo = [0, 0]
  let houses = new Set()
  houses.add('0,0')
  input.split('').forEach((dir, idx) => {
    let current = idx % 2 ? currentRobo : currentSanta
    switch (dir) {
    case '>':
      current[1] += 1
      break;
    case '<':
      current[1] -= 1
      break
    case '^':
      current[0] += 1
      break
    case 'v':
      current[0] -= 1
      break
    }
    houses.add(`${current[0]},${current[1]}`)
  })
  return houses.size

}

const input = fs.readFileSync('inputs/day3.txt', {'encoding': 'utf8'}).trim()
console.log(`Part 1: ${part1(input)}`)
console.log(`Part 2: ${part2(input)}`)

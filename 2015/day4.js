// Requires installing `md5` from npm
const fs = require('fs')
const md5 = require('md5')

const part1 = (input) => {
  let num = 1
  while (md5(`${input}${num}`).slice(0, 5) !== '00000') {
    num++
  }
  return num
}

const part2 = (input) => {
  let num = 1
  while (md5(`${input}${num}`).slice(0, 6) !== '000000') {
    num++
  }
  return num
}

const input = fs.readFileSync('inputs/day4.txt', {'encoding': 'utf8'}).trim()
console.log(`Part 1: ${part1(input)}`)
console.log(`Part 2: ${part2(input)}`)

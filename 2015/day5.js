const fs = require('fs')

const part1 = (input) => {
  const isNice = (word) => {
    const vowels = 'aeiou'
    const includes = ['ab', 'cd', 'pq', 'xy']
          .map(e => word.includes(e))
          .reduce((acc, el) => acc || el, false)
    const has3Vowels = word
          .split('')
          .reduce((acc, el) => acc + (vowels.includes(el) ? 1: 0), 0) >= 3
    return (!includes) && word.match(/(.)\1/) && has3Vowels
  }

  return input
    .split('\n')
    .map(isNice)
    .reduce((acc, el) => acc + (el ? 1 : 0), 0)
}

const part2 = (input) => {
  const isNice = word => {
    const rule1 = word.match(/([a-z]{2}).*\1/)
    const rule2 = word.match(/([a-z])[a-z]\1/)
    return rule1 && rule2
  }

  return input
    .split('\n')
    .map(isNice)
    .reduce((acc, el) => acc + (el ? 1 : 0), 0)
}

const input = fs.readFileSync('inputs/day5.txt', {'encoding': 'utf8'}).trim()
console.log(`Part 1: ${part1(input)}`)
console.log(`Part 2: ${part2(input)}`)

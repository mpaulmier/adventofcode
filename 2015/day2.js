const fs = require('fs')

const part1 = (input) => {
  return input
    .split('\n')
    .map((line) => {
      const [l, w, h] = line.split('x').map(x => parseInt(x))
      const largest = Math.max(l, w, h)
      const smallest = Math.min(l, w, h)
      const smallestArea = smallest * (l + w + h - smallest - largest)
      return 2*l*w + 2*w*h + 2*h*l + smallestArea
    })
    .reduce((acc, el) => acc + el, 0)
}

const part2 = (input) => {
  return input
    .split('\n')
    .map((line) => {
      const [l, w, h] = line.split('x').map(x => parseInt(x))
      const extraRibbon = l * w * h
      const largest = Math.max(l, w, h)
      const smallestSide = (2 * l + 2 * w + 2 * h) - 2 * largest
      return smallestSide + extraRibbon
    })
    .reduce((acc, el) => acc + el, 0)
}

const input = fs.readFileSync('inputs/day2.txt', {'encoding': 'utf8'}).trim()
console.log(`Part 1: ${part1(input)}`)
console.log(`Part 2: ${part2(input)}`)

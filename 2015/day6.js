const fs = require('fs')

const part1 = (input) => {
  let grid = Array(1000)
      .fill(0)
      .map(_ => Array(1000).fill(0))
  input
    .split('\n')
    .forEach((el) => {
      const [_, command, sx, sy, ex, ey] = el.match(/(.*)\ (\d+),(\d+)\ through\ (\d+),(\d+)/i)
      const [startX, startY, endX, endY] = [sx, sy, ex, ey].map(e => parseInt(e))
      for (let i = startX; i <= endX; i++) {
        for (let j = startY; j <= endY; j++) {
          if (command === 'toggle') {
            grid[i][j] = (grid[i][j] + 1) % 2
          }
          else {
            const turn = {'on': 1, 'off': 0}
            grid[i][j] = turn[command.split(' ')[1]]
          }
        }
      }
    })
  return grid.reduce((lineAcc, line) => lineAcc + line.reduce((acc, el) => acc + el, 0), 0)
}

const part2 = (input) => {
  let grid = Array(1000)
      .fill(0)
      .map(_ => Array(1000).fill(0))
  input
    .split('\n')
    .forEach((el) => {
      const [_, command, sx, sy, ex, ey] = el.match(/(.*)\ (\d+),(\d+)\ through\ (\d+),(\d+)/i)
      const [startX, startY, endX, endY] = [sx, sy, ex, ey].map(e => parseInt(e))
      for (let i = startX; i <= endX; i++) {
        for (let j = startY; j <= endY; j++) {
          if (command === 'toggle') {
            grid[i][j] += 2
          }
          else {
            const turn = {'on': 1, 'off': -1}
            grid[i][j] += turn[command.split(' ')[1]]
            grid[i][j] = Math.max(grid[i][j], 0)
          }
        }
      }
    })
  return grid.reduce((lineAcc, line) => lineAcc + line.reduce((acc, el) => acc + el, 0), 0)
}

const input = fs.readFileSync('inputs/day6.txt', {'encoding': 'utf8'}).trim()
console.log(`Part 1: ${part1(input)}`)
console.log(`Part 2: ${part2(input)}`)

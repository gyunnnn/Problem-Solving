import Foundation

let NLR = readLine()!.split(separator: " ").map { Int($0)! }
let N = NLR[0], L = NLR[1], R = NLR[2]
var land = [[Int]]()

for _ in 0..<N {
    land.append(readLine()!.split(separator: " ").map { Int($0)! })
}

var days = 0

while true {
    var visited = Array(repeating: Array(repeating: false, count: N), count: N)
    var hasUnion = false

    for i in 0..<N {
        for j in 0..<N {
            if !visited[i][j] {
                let union = findUnion(i, j, &visited)
                if union.count > 1 {
                    hasUnion = true
                    let avg = calculateAverage(union)
                    updatePopulation(union, avg)
                }
            }
        }
    }

    if !hasUnion { break }
    days += 1
}

print(days)

func findUnion(_ i: Int, _ j: Int, _ visited: inout [[Bool]]) -> [(Int, Int)] {
    let dy = [-1, 1, 0, 0]
    let dx = [0, 0, -1, 1]
    let N = visited.count
  
    var stack = [(Int, Int)]()
    var union = [(Int, Int)]()
    
    stack.append((i, j))
    visited[i][j] = true
    union.append((i, j))
    
    while !stack.isEmpty {
        let (x, y) = stack.popLast()!
        
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            guard 0..<N ~= nx, 0..<N ~= ny else { continue }
            if visited[nx][ny] { continue }
            
            if L <= abs(land[nx][ny] - land[x][y]) && abs(land[nx][ny] - land[x][y]) <= R {
                stack.append((nx, ny))
                visited[nx][ny] = true
                union.append((nx, ny))
            }
        }
    }

    return union
}

func calculateAverage(_ union: [(Int, Int)]) -> Int {
  var total = 0
  
  for (i, j) in union {
    total += land[i][j]
  }
    
  return total / union.count
}

func updatePopulation(_ union: [(Int, Int)], _ average: Int) {
  for (i, j) in union {
    land[i][j] = average
  }
}
import Foundation

let NMH = readLine()!.split(separator: " ").map { Int($0)! }
let N = NMH[0], M = NMH[1], H = NMH[2]
var horizontalLines = [(Int, Int)]()
var ladder = Array(repeating: Array(repeating: false, count: N + 1), count: H + 1)
var answer = -1

for _ in 0..<M {
    let ab = readLine()!.split(separator: " ").map { Int($0)! }
    let a = ab[0], b = ab[1]
    ladder[a][b] = true
}

func simulateLadder() -> Bool {
    
    for start in 1...N {
        var current = start
        
        for level in 1...H {
            if current < N && ladder[level][current] {
                current += 1
            } else if current > 1 && ladder[level][current - 1] {
                current -= 1
            }
        }
        
        if current != start {
            return false
        }
    }
    return true
}

func canPlace(_ row: Int, _ column: Int) -> Bool {
    if ladder[row][column] {
        return false
    }
    
    if 1 < column && ladder[row][column - 1] {
        return false
    }
    
    if column < N && ladder[row][column + 1] {
        return false
    }
    
    return true
}

func backtrack(count: Int, startRow: Int, startColumn: Int) {
    
    if simulateLadder() {
        answer = min(answer == -1 ? count : answer, count)
        return
    }
    
    if count >= 3 {
        return
    }
    
    for row in startRow...H {
        let columnStart = (row == startRow) ? startColumn : 1
        
        for column in columnStart..<N {
            if canPlace(row, column) {
                ladder[row][column] = true
                backtrack(count: count + 1, startRow: row, startColumn: column + 1)
                ladder[row][column] = false
            }
        }
    }
}

backtrack(count: 0, startRow: 1, startColumn: 1)
print(answer)
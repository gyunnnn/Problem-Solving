import Foundation

let rc = readLine()!.split(separator: " ").map { Int($0)! }
let r = rc.first!, c = rc.last!
var board = [[Int]]()

for _ in 0..<r {
    board.append(Array(readLine()!.utf8).map { Int($0) - 65 })
}

var visited = 0
var answer = 0

let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]

func dfs(_ x: Int, _ y: Int, _ count: Int) {
    answer = max(answer, count)
    
    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        
        guard nx >= 0, nx < r, ny >= 0, ny < c else { continue }
        
        let charBit = 1 << board[nx][ny]
        
        if visited & charBit != 0 { continue }
        
        visited |= charBit
        dfs(nx, ny, count + 1)
        visited ^= charBit
    }
}

visited |= (1 << board[0][0])
dfs(0, 0, 1)

print(answer)
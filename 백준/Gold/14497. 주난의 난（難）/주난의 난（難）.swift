import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm.first!, m = nm.last!
let positions = readLine()!.split(separator: " ").map { Int($0)! - 1 }
let y1 = positions[0], x1 = positions[1], y2 = positions[2], x2 = positions[3]

let dy = [-1, 0, 1, 0], dx = [0, 1, 0, -1]
var map = [[String]]()
var visited = Array(repeating: Array(repeating: false, count: m), count: n)
var friendsPosition = Set<String>()
var find = false
var answer = 0

for _ in 0..<n {
    map.append(readLine()!.map { String($0) })
}

func dfs(_ y: Int, _ x: Int) {
    if map[y][x] == "1" {
        friendsPosition.insert("\(y) \(x)")
        return
    }
    
    if find {
        return
    }
    
    visited[y][x] = true
    
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        
        guard 0 <= ny, ny < n, 0 <= nx, nx < m else { continue }
        
        if visited[ny][nx] { continue }
        
        if map[ny][nx] == "1" {
            friendsPosition.insert("\(ny) \(nx)")
            continue
        }
        
        if map[ny][nx] == "#" {
            find = true
            return
        }
        
        dfs(ny, nx)
    }
}

while !find {
    dfs(y1, x1)
    
    for position in friendsPosition {
        let coordinate = position.split(separator: " ").map { Int($0)! }
        map[coordinate[0]][coordinate[1]] = "0"
    }
    
    friendsPosition.removeAll()
    answer += 1
    visited = Array(repeating: Array(repeating: false, count: m), count: n)
}

print(answer)
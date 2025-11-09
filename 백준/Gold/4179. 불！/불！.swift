import Foundation

let rc = readLine()!.split(separator: " ").map { Int($0)! }
let r = rc.first!, c = rc.last!

var map = [[Character]]()
let dr = [-1, 1, 0, 0]
let dc = [0, 0, -1, 1]

var time = 0
var queue = [(Int, Int)]()
var level = 0
var visited = Array(repeating: Array(repeating: false, count: c), count: r)

var fireQueue = [(Int, Int)]()
var fireLevel = 0
var isPossible = false

for i in 0..<r {
    var line = Array(readLine()!)
    for j in 0..<c {
        if line[j] == "J" {
            line[j] = "."
            visited[i][j] = true
            queue.append((i, j))
        } else if line[j] == "F" {
            fireQueue.append((i, j))
        }
    }
    map.append(line)
}

func spreadFire() {
    let head = fireLevel
    fireLevel = fireQueue.count
    
    for i in head..<fireQueue.count {
        let front = fireQueue[i]
        
        for j in 0..<4 {
            let nf = (front.0 + dr[j], front.1 + dc[j])
            if nf.0 < 0 || nf.0 >= r || nf.1 < 0 || nf.1 >= c { continue }
            if map[nf.0][nf.1] == "." {
                map[nf.0][nf.1] = "F"
                fireQueue.append(nf)
            }
        }
    }
}

func move() {
    let head = level
    level = queue.count
    
    for i in head..<queue.count {
        let front = queue[i]
        
        if front.0 == 0 || front.1 == 0 || front.0 == r - 1 || front.1 == c - 1 { isPossible = true }
        
        for j in 0..<4 {
            let n = (front.0 + dr[j], front.1 + dc[j])
            if n.0 < 0 || n.0 >= r || n.1 < 0 || n.1 >= c { continue }
            if map[n.0][n.1] == "." && !visited[n.0][n.1] {
                visited[n.0][n.1] = true
                queue.append(n)
            }
        }
    }
}


while level < queue.count && !isPossible {
    time += 1
    spreadFire()
    move()
}

print(isPossible ? time : "IMPOSSIBLE")
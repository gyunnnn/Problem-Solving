import Foundation

let nk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nk[0], k = nk[1]

var visited = Array(repeating: false, count: 100_001)
var parent = Array(repeating: -1, count: 100_001)

var queue = [(position: Int, count: Int)]()
var head = 0

visited[n] = true
queue.append((n, 0))

while head < queue.count {

    let present = queue[head]
    head += 1
    
    if present.position == k {
        print(present.count)
        
        var path = [Int]()
        var current = k
        while current != -1 {
            path.append(current)
            current = parent[current]
        }
    
        print(path.reversed().map { String($0) }.joined(separator: " "))
        break
    }
    
    let moves = [present.position - 1, present.position + 1, present.position * 2]
    
    for newPosition in moves {
        if newPosition < 0 || newPosition > 100_000 { continue }
        if visited[newPosition] { continue }
        
        visited[newPosition] = true
        parent[newPosition] = present.position
        queue.append((newPosition, present.count + 1))
    }
}
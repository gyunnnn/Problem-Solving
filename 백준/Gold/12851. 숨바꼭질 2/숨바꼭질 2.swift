import Foundation

let nk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nk[0], k = nk[1]

var distance = Array(repeating: -1, count: 100_001)
var ways = Array(repeating: 0, count: 100_001)

var queue = [Int]()
var head = 0

distance[n] = 0
ways[n] = 1
queue.append(n)

while head < queue.count {
    let present = queue[head]
    head += 1
    
    let moves = [present - 1, present + 1, present * 2]
    
    for newPosition in moves {
        if newPosition < 0 || newPosition > 100_000 { continue }
        
        if distance[newPosition] == -1 {
            distance[newPosition] = distance[present] + 1
            ways[newPosition] = ways[present]
            queue.append(newPosition)
        } else if distance[newPosition] == distance[present] + 1 {
            ways[newPosition] += ways[present]
        }
    }
}

print(distance[k])
print(ways[k])
import Foundation

let n = Int(readLine()!)!
var scvs = readLine()!.split(separator: " ").map { Int($0)! }

var queue = [(Int, Int, Int, Int)]()
var head = 0
var visited = Set<[Int]>()

let attacks = [
    (1, 3, 9),
    (1, 9, 3),
    (3, 1, 9),
    (3, 9, 1),
    (9, 1, 3),
    (9, 3, 1),
]

let initial = Array((scvs + [0, 0, 0])).prefix(3).sorted(by: >)
queue.append((initial[0], initial[1], initial[2], 0))
visited.insert(initial)

while head < queue.count {
    let (hp1, hp2, hp3, count) = queue[head]
    head += 1
    
    if hp1 == 0, hp2 == 0, hp3 == 0 {
        print(count)
        break
    }
    
    for (d1, d2, d3) in attacks {
        let nextHp = [
            max(0, hp1 - d1),
            max(0, hp2 - d2),
            max(0, hp3 - d3)
        ].sorted(by: >)
        
        if !visited.contains(nextHp) {
            visited.insert(nextHp)
            queue.append((nextHp[0], nextHp[1], nextHp[2], count + 1))
        }
    }
}
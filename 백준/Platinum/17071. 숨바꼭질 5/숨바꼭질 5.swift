import Foundation

let NK = readLine()!.split(separator: " ").map { Int($0)! }
let N = NK[0]
var K = NK[1]
var visited = Array(repeating: Array(repeating: false, count: 2), count: 500_010)
var queue = [Int]()
var head = 0
var time = 0
var isImpossible = true

visited[N][0] = true

queue.append(N)

while head < queue.count {

    if K > 500_000 {
        break
    }

    if K <= 500_000 && visited[K][time % 2] == true {
        isImpossible = false
        break
    }

    let level = queue.count - head

    for _ in 0..<level {
        let front = queue[head]
        head += 1

        for position in [front - 1, front + 1, front * 2] {
            if position < 0 || position > 500_000 { continue }
            if visited[position][(time + 1) % 2] { continue }
            visited[position][(time + 1) % 2] = true
            queue.append(position)
        }
    }

    time += 1
    K += time
}

print(isImpossible ? -1 : time)
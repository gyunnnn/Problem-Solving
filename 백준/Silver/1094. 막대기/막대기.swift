import Foundation

let X = Int(readLine()!)!
var sticks = [64]

while sticks.reduce(0, +) != X {
    let half = sticks.last! / 2
    let n = sticks.count
    
    if (sticks[0..<n-1].reduce(0, +) + half) >= X {
        let _ = sticks.popLast()
        sticks.append(half)
    } else {
        let last = sticks.popLast()!
        sticks.append(last/2)
        sticks.append(last/2)
    }
}

print(sticks.count)
import Foundation

let n = Int(readLine()!)!
// 단백질, 지방, 탄수화물, 비타민
let minimum = readLine()!.split(separator: " ").map { Int($0)! }

var ingredients = [[Int]]()
var answer = Int.max
var answerNumbers = [Int]()

for _ in 0..<n {
    ingredients.append(
        readLine()!.split(separator: " ").map { Int($0)! }
    )
}

for mask in 1..<(1 << n) {
    var basket = Array(repeating: 0, count: 5)
    var selectedNumbers = [Int]()
    
    for j in 0..<n {
        if mask & (1 << j) != 0 {
            for k in 0...4 {
                basket[k] += ingredients[j][k]
            }
            selectedNumbers.append(j + 1)
        }
    }
    
    var isSatisfied = true
    
    for i in 0..<4 {
        if basket[i] < minimum[i] {
            isSatisfied = false
            break
        }
    }
    // 갱신
    if isSatisfied {
        if basket[4] < answer
            || (basket[4] == answer && selectedNumbers.lexicographicallyPrecedes(answerNumbers))
        {
            answer = basket[4]
            answerNumbers = selectedNumbers
        }
    }
}

if answer == Int.max {
    print(-1)
} else {
    print(answer)
    print(answerNumbers.map { String($0) }.joined(separator: " "))
}
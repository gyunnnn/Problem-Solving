import Foundation

func wordToBit(_ word: String) -> Int {
    var bit = 0
    for char in word {
        let index = Int(char.asciiValue!) - 97
        bit |= (1 << index)
    }
    return bit
}

let nk = readLine()!.split(separator: " ").map { Int($0)! }
var words = [String]()
var learned = 0
var answer = 0
var wordBits = [Int]()

for _ in 0..<nk.first! {
    words.append(String(readLine()!.dropFirst(4).dropLast(4)))
}

for char in "acint" {
    let index = Int(char.asciiValue!) - 97
    learned |= (1 << index)
}

for word in words {
    wordBits.append(wordToBit(word))
}

func backtrack(index: Int, count: Int, learned: Int) {
    if count == nk.last! - 5 {
        var readable = 0
        for wordBit in wordBits {
            if (wordBit & learned) == wordBit {
                readable += 1
            }
        }
        answer = max(answer, readable)
        return
    }
    
    if index == 26 {
        return
    }
    
    if learned & (1 << index) != 0 {
        backtrack(index: index + 1, count: count, learned: learned)
        return
    }
    
    backtrack(index: index + 1, count: count + 1, learned: learned | (1 << index))
    backtrack(index: index + 1, count: count, learned: learned)
}

if nk.last! < 5 {
    print(0)
} else {
    backtrack(index: 0, count: 0, learned: learned)
    print(answer)
}
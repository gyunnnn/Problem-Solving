import Foundation

let t = Int(readLine()!)!

for _ in 0..<t {
    let command = Array(readLine()!).map { String($0) }
    let _ = Int(readLine()!)!
    let array = readLine()!.dropFirst().dropLast().split(separator: ",").map { Int($0)! }
    
    var left = 0
    var right = array.count - 1
    var isReversed = false
    var isError = false
    
    for string in command {
        switch string {
        case "R":
            isReversed.toggle()
        case "D":
            if left > right {
                isError = true
            } else {
                isReversed ? (right -= 1) : (left += 1)
            }
            
        default: break
        }
        
        if isError { break }
    }
    
    if isError {
        print("error")
    } else {
        if left > right {
            print("[]")
        } else {
            let answer = isReversed ? Array(array[left...right].reversed()) : Array(array[left...right])
            
            print("[\(answer.map { String($0) }.joined(separator: ","))]")
        }
    }
}
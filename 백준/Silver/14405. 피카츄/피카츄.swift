import Foundation

let s = Array(readLine()!)
let n = s.count
var index = 0
var pronounceable = true

while index < n {
    switch s[s.index(s.startIndex, offsetBy: index)] {
    case "p":
        guard 0..<n ~= index+1 else {
            print("NO")
            exit(0)
        }
        if s[s.index(s.startIndex, offsetBy: index+1)] == "i" {
            index += 2
        } else {
            print("NO")
            exit(0)
        }
    case "k":
        guard 0..<n ~= index+1 else {
            print("NO")
            exit(0)
        }
        if s[s.index(s.startIndex, offsetBy: index+1)] == "a" {
            index += 2
        } else {
            print("NO")
            exit(0)
        }
    case "c":
        guard 0..<n ~= index+1 && 0..<n ~= index+2 else {
            print("NO")
            exit(0)
        }
        if s[s.index(s.startIndex, offsetBy: index+1)] == "h" && s[s.index(s.startIndex, offsetBy: index+2)] == "u" {
            index += 3
        } else {
            print("NO")
            exit(0)
        }
    default:
        print("NO")
        exit(0)
    }
}

print("YES")
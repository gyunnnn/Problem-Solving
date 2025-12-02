import Foundation

let abc = readLine()!.split(separator: " ").map { Int($0)! }
let a = abc[0], b = abc[1], c = abc[2]

func multiply(_ a: Int, _ b: Int, _ c: Int) -> Int {
    if b == 1 { return a % c }
    var value = multiply(a, b/2, c)
    value = value * value % c
    if b % 2 == 0 { return value }
    return value * a % c
}

print(multiply(a, b, c))
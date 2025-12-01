import Foundation

while let line = readLine(), let number = Int(line) {
    var remainder = 1 % number
    var length = 1
    
    while remainder != 0 {
        remainder = (remainder * 10 + 1) % number
        length += 1
    }
    
    print(length)
}
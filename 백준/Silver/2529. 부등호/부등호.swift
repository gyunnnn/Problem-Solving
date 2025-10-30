import Foundation

let k = Int(readLine()!)!
var inequalitySign = readLine()!

func solveOptimized(_ brackets: String) -> (max: String, min: String) {
    let signs = Array(brackets.replacingOccurrences(of: " ", with: ""))
    let k = signs.count
    
    var maxResult = ""
    var minResult = ""
    
    func findMax() -> String {
        var current: [Int] = []
        var used = [Bool](repeating: false, count: 10)
        
        @discardableResult func backtrack(_ depth: Int) -> Bool {
            if depth == k + 1 {
                maxResult = current.map(String.init).joined()
                return true
            }
            
            for num in (0...9).reversed() {
                if used[num] { continue }
                
                if depth > 0 {
                    let prevNum = current[depth - 1]
                    let sign = signs[depth - 1]
                    
                    if sign == "<" && prevNum >= num { continue }
                    if sign == ">" && prevNum <= num { continue }
                }
                
                current.append(num)
                used[num] = true
                
                if backtrack(depth + 1) { return true }
                
                current.removeLast()
                used[num] = false
            }
            
            return false
        }
        
        backtrack(0)
        return maxResult
    }
    
    func findMin() -> String {
        var current: [Int] = []
        var used = [Bool](repeating: false, count: 10)
        
        @discardableResult func backtrack(_ depth: Int) -> Bool {
            if depth == k + 1 {
                minResult = current.map(String.init).joined()
                return true
            }
            
            for num in 0...9 {
                if used[num] { continue }
                
                if depth > 0 {
                    let prevNum = current[depth - 1]
                    let sign = signs[depth - 1]
                    
                    if sign == "<" && prevNum >= num { continue }
                    if sign == ">" && prevNum <= num { continue }
                }
                
                current.append(num)
                used[num] = true
                
                if backtrack(depth + 1) { return true }
                
                current.removeLast()
                used[num] = false
            }
            
            return false
        }
        
        backtrack(0)
        return minResult
    }
    
    return (findMax(), findMin())
}

let result = solveOptimized(inequalitySign)

print(result.max)
print(result.min)
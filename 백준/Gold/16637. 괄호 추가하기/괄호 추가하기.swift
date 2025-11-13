import Foundation

let n = Int(readLine()!)!
var numbers = [Int]()
var operators = [Character]()
var answer = Int.min

for character in readLine()! {
    character.isNumber ? (numbers.append(Int(String(character))!)) : (operators.append(character))
}

var bracket = Array(repeating: false, count: operators.count)

func select(_ index: Int) {
    guard index < bracket.count else {
        calculate()
        return
    }
    
    bracket[index] = true
    select(index + 2)
    bracket[index] = false
    select(index + 1)
}

func operate(_ lhs: Int, _ rhs: Int, _ operator: Character) -> Int {
    switch `operator` {
    case "+": return lhs + rhs
    case "-": return lhs - rhs
    default: return lhs * rhs
    }
}

func calculate() {
    var operateResults = numbers
    
    for index in bracket.indices where bracket[index] {
        operateResults[index] = operate(operateResults[index], operateResults[index + 1], operators[index])
    }
    
    for (index, `operator`) in operators.enumerated() {
        operateResults[index + 1] = bracket[index] ? operateResults[index] : operate(operateResults[index], operateResults[index + 1], `operator`)
    }
    
    answer = max(answer, operateResults.last!)
}

select(0)
print(answer)
import Foundation

func getCombination(_ array: [[Int]]) -> [[(row: Int, column: Int, value: Int)]] {
  
  var elements: [(row: Int, column: Int, value: Int)] = []
  
  for r in 0..<array.count {
    for c in 0..<array[r].count {
      elements.append((r, c, array[r][c]))
    }
  }
  
  var result: [[(row: Int, column: Int, value: Int)]] = []
  let n = elements.count
  
  for i in 0..<n-2 {
    for j in i+1..<n-1 {
      for k in j+1..<n {
        result.append([elements[i], elements[j], elements[k]])
      }
    }
  }
  return result
}

let dy = [-1, 1, 0, 0, 0]
let dx = [0, 0, -1, 1, 0]

func getFlowerCost(row: Int, column: Int) -> Int? {
  var cost = 0
  
  for i in 0..<5 {
    let nr = row + dy[i]
    let nc = column + dx[i]
    
    if nr < 0 || nr >= n || nc < 0 || nc >= n {
      return nil
    }
    
    cost += flowers[nr][nc]
  }
  
  return cost
}

let n = Int(readLine()!)!
var flowers = [[Int]]()


for _ in 0..<n {
  flowers.append(readLine()!.split(separator: " ").map { Int($0)! })
}

let combinations = getCombination(flowers)

var costs = [Int]()
var minCost = Int.max

for combination in combinations {
  var isValid = true
  var totalCost = 0
  var allPositions = Set<String>()
  
  for location in combination {

    var currentFlowerCost = 0
    
    for i in 0..<5 {
      let nr = location.row + dy[i]
      let nc = location.column + dx[i]
      
      if nr < 0 || nr >= n || nc < 0 || nc >= n {
        isValid = false
        break
      }
      
      let key = "\(nr), \(nc)"
      if allPositions.contains(key) {
        isValid = false
        break
      }
      
      allPositions.insert(key)
      currentFlowerCost += flowers[nr][nc]
    }
    
    if !isValid { break }
    totalCost += currentFlowerCost
  }
  
  if isValid {
    minCost = min(totalCost, minCost)
  }
}

print(minCost)
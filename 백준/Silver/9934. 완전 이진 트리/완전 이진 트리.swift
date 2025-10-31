import Foundation

let k = Int(readLine()!)!
let buildingOrders = readLine()!.split(separator: " ").map { Int($0)! }

var levels = Array(repeating: [Int](), count: k)

func inorder(_ start: Int, _ end: Int, _ level: Int) {
  if start > end { return }
  let mid = (start + end) / 2
  levels[level].append(buildingOrders[mid])
  
  inorder(start, mid - 1, level + 1)
  inorder(mid + 1, end, level + 1)
}

inorder(0, buildingOrders.count - 1, 0)

for level in levels {
  print(level.map { String($0) }.joined(separator: " ") )
}
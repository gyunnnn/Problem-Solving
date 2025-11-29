import Foundation

let RC = readLine()!.split(separator: " ").map { Int($0)! }
let R = RC[0], C = RC[1]
var grid = [[String]]()
var answer = 0

var currentLocations = [(Int, Int)]()
var currentLocationsHead = 0
var nextLocations = [(Int, Int)]()
var nextLocationsHead = 0

var currentWater = [(Int, Int)]()
var currentWaterHead = 0
var nextWater = [(Int, Int)]()
var nextWaterHead = 0

var visited = Array(repeating: Array(repeating: false, count: C), count: R)

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

for _ in 0..<R {
    grid.append(
        Array(readLine()!).map { String($0) }
    )
}

for i in 0..<R {
    for j in 0..<C {
        if grid[i][j] == "L" {
            if currentLocations.isEmpty {
                currentLocations.append((i, j))
                visited[i][j] = true
            }
            currentWater.append((i, j))
        } else if grid[i][j] == "." {
            currentWater.append((i, j))
        }
    }
}

func meltIce() {
    var visited = Array(repeating: Array(repeating: false, count: C), count: R)
    
    while currentWaterHead < currentWater.count {
        
        let currentPosition = currentWater[currentWaterHead]
        currentWaterHead += 1
        
        for i in 0..<4 {
            let nr = currentPosition.0 + dy[i]
            let nc = currentPosition.1 + dx[i]
            
            guard 0..<R ~= nr, 0..<C ~= nc else { continue }
            guard !visited[nr][nc] else { continue }
            guard grid[nr][nc] == "X" else { continue }
            
            visited[nr][nc] = true
            grid[nr][nc] = "."
            nextWater.append((nr, nc))
        }
    }
    
    currentWater = nextWater
    currentWaterHead = 0
    
    nextWater = []
    nextWaterHead = 0
}


while true {
    
    while currentLocationsHead < currentLocations.count {
        let currentPosition = currentLocations[currentLocationsHead]
        currentLocationsHead += 1
        
        for i in 0..<4 {
            let nr = currentPosition.0 + dy[i]
            let nc = currentPosition.1 + dx[i]
            
            guard 0..<R ~= nr, 0..<C ~= nc else { continue }
            guard !visited[nr][nc] else { continue }
            
            visited[nr][nc] = true
            
            switch grid[nr][nc] {
            case "L": // 백조
                print(answer)
                exit(0)
            case ".": // 물
                currentLocations.append((nr, nc))
            default: // 얼음
                nextLocations.append((nr, nc))
            }
        }
        
    }
    
    meltIce()
    
    currentLocations = nextLocations
    currentLocationsHead = 0
    
    nextLocations = []
    nextLocationsHead = 0
    
    answer += 1
}

print(answer)
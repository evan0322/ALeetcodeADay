//: [Previous](@previous)

import Foundation

func orangesRotting(_ grid: [[Int]]) -> Int {
    var count = 0
    var stack = [[Int]]()
    var fresh = 0
    var grid = grid
    
    for i in 0..<grid.count {
        for j in 0..<grid[i].count {
            if grid[i][j] == 2 {
                stack.append([i, j])
            } else if grid[i][j] == 1 {
                fresh += 1
            }
            
        }
    }
    
    func bfsOnce(stack:[[Int]]) -> [[Int]] {
        var dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]]
        var result = [[Int]]()
        for point in stack {
            for dir in dirs {
                let i = point[0] + dir[0]
                let j = point[1] + dir[1]
                if i < 0 || i >= grid.count || j < 0 || j >= grid[i].count {
                    continue
                }
            
                if grid[i][j] == 0 || grid[i][j] == 2 {
                    continue
                }
            
                grid[i][j] = 2
                fresh -= 1
                result.append([i, j])
            }
        }
    
        return result
    }
    
    while stack.count != 0 {
        stack =  bfsOnce(stack:stack)
        if stack.count > 0 {
            count += 1
        }
    }
    
    return fresh == 0 ? count : -1
            
}

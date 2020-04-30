//: [Previous](@previous)

import Foundation

func orangesRotting(_ grid: [[Int]]) -> Int {
   guard grid.count > 0, grid[0].count > 0 else {
       return 0
   }
    
    var freshOranges = 0
    var grid = grid
    var minutes = 0
    var stack = [[Int]]()
    
    for i in 0..<grid.count {
        for j in 0..<grid[i].count {
            if grid[i][j] == 1 {
                freshOranges += 1
            } else if grid[i][j] == 2 {
                stack.append([i, j])
            }
        }
    }
    
    let dirs = [[0, 1], [1, 0], [-1, 0], [0, -1]]
    
    while stack.count != 0 {
        var newStack = [[Int]]()
        for node in stack {
            for dir in dirs {
                let i = node[0] + dir[0]
                let j = node[1] + dir[1]
                if i < 0 || j < 0 || i >= grid.count || j >= grid[i].count {
                    continue
                }
                
                if grid[i][j] == 1 {
                    grid[i][j] = 2
                    newStack.append([i, j])
                    freshOranges -= 1
                }
            }
        }
        
        stack = newStack
        if stack.count > 0 {
            minutes += 1
        }
    }
    
    return freshOranges == 0 ? minutes : -1
            
}

//: [Previous](@previous)

import Foundation

func wallsAndGates(_ rooms: inout [[Int]]) {
    guard rooms.count > 0, rooms[0].count > 0 else{
        return
    }
    
    var stack = [[Int]]()
    var dirs = [[0,1], [1, 0], [-1, 0], [0, -1]]
    
    for i in 0..<rooms.count {
        for j in 0..<rooms[i].count {
            if rooms[i][j] == 0 {
                stack.append([i, j])
            }
        }
    }
    
    var step = 1
    
    while stack.count != 0 {
        var newStack = [[Int]]()
        for room in stack {
            for dir in dirs {
                let i = room[0] + dir[0]
                let j = room[1] + dir[1]
                
                if i < 0 || j < 0 || i >= rooms.count || j >= rooms[i].count || rooms[i][j] != 2147483647  {
                    continue
                }
                
                rooms[i][j] = step
                
                newStack.append([i,j])
             }
        }
        
        stack = newStack
        step += 1
    }
}

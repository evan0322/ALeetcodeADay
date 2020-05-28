//: [Previous](@previous)

import Foundation

func snakesAndLadders(_ board: [[Int]]) -> Int {
    guard board.count > 0, board[0].count > 0 else {
        return -1
    }
    
    let arr = flatten(board)
    
    var stack = [Int]()
    let start = arr[0] > -1 ? arr[0] - 1 : 0
    stack.append(start)
    
    var count = 0
    var visited = Set<Int>()
    
    while stack.count != 0 {
        print(stack)
        var newStack = [Int]()
        for grid in stack {
            if grid == arr.count - 1 {
                return count
            }
            
            for i in grid + 1...min(grid + 6, arr.count - 1) {
                let dest = arr[i] != -1 ? arr[i] - 1 : i
                if !visited.contains(dest) {
                    visited.insert(dest)
                    newStack.append(dest)
                }
            }
              
        }
        count += 1
        stack = newStack
    }
    
    
    return -1
}


func flatten(_ board:[[Int]]) -> [Int] {
    var arr = [Int]()
    var count = 0
    
    for i in (0..<board.count).reversed() {
        if count % 2 == 0 {
            arr += board[i]
        } else {
            arr += Array(board[i].reversed())
        }
        count += 1
    }
    
    return arr
}

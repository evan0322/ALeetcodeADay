//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


//Note the value of dirs
func generateMatrix(_ n: Int) -> [[Int]] {
    guard n > 0 else {
        return [[Int]]()
    }
    
    let dirs = [[0, 1],
                [1, 0],
                [0, -1],
                [-1, 0]]
    
    var result = Array(repeating:Array(repeating:-1,count:n), count:n)
    
    // var i = 0
    // var j = 0
    // var index = 1
    var dirIndex = 0
    var index = 1
    
    func fill(i:Int, j:Int) {
        if i >= n || i < 0 || j >= n || j < 0 || result[i][j] != -1 {
            return
        }
        
        result[i][j] = index
        index += 1
        
        if !isValidNext(i:i + dirs[dirIndex][0], j:j + dirs[dirIndex][1]) {
            dirIndex = (dirIndex + 1) % 4
        }
        
        var nextI = i + dirs[dirIndex][0]
        var nextJ = j + dirs[dirIndex][1]
        
        if !isValidNext(i:nextI, j:nextJ) {
                return
        }
        
        fill(i:nextI,j:nextJ)
        
        
    }
    
    func isValidNext(i:Int, j:Int) -> Bool {
        if i >= n || i < 0 || j >= n || j < 0 || result[i][j] != -1 {
            return false
        }
        
        return true
    }
    
    fill(i:0,j:0)
    
    return result
    
}

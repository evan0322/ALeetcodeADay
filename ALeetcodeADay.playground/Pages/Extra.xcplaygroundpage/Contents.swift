//: [Previous](@previous)

import Foundation


//How to merge k sorted array into 1 array
func mergeKArray(arr:[[Int]]) -> [Int] {
    guard arr.count > 0 else {
        return [Int]()
    }
    
    guard arr.count > 1 else {
        return arr[0]
    }
    
    guard arr.count > 2 else {
        return merge(left: arr[0], right: arr[1])
    }
    
    
    let left = mergeKArray(arr: Array(arr[0..<arr.count/2]))
    let right = mergeKArray(arr: Array(arr[arr.count/2..<arr.count]))
    
    return merge(left: left, right: right)
}

func merge(left:[Int], right:[Int]) -> [Int] {
    
    
    var temp = [Int]()
    var i = 0
    var j = 0
    while i < left.count && j < right.count {
        if left[i] < right[j] {
            temp.append(left[i])
            i += 1
        } else if left[i] > right[j] {
            temp.append(right[j])
            j += 1
        } else {
            temp.append(left[i])
            temp.append(right[j])
            i += 1
            j += 1
        }
    }
    
    while i < left.count {
        temp.append(left[i])
        i += 1
    }
    while j < right.count {
        temp.append(right[j])
        j += 1
    }
    
    return temp
}


//Image you have a room presented by matrix filled with 1s and 0s. 1 means you cannot go through the grid.
//Print all the possible ways to go from top-left corner to down-right corner. Note you can only move down or right at a time
func allPath(matrix:[[Int]]) -> [[[Int]]] {
    guard matrix.count > 0 else {
        return [[[Int]]]()
    }
    
    var result = [[[Int]]]()
    
    func dfs(i:Int, j:Int, curPath:[[Int]]) {
        if i < 0 || j < 0 || i >= matrix.count || j >= matrix[0].count || matrix[i][j] == 1 {
            return
        }
        
        var curPath = curPath + [[i, j]]
        
        if i == matrix.count - 1 && j == matrix[0].count - 1 {
            result.append(curPath)
        }
        
        dfs(i: i + 1, j: j, curPath: curPath)
        dfs(i: i, j: j + 1, curPath: curPath)
        
    }
    
    dfs(i: 0, j: 0, curPath: [[Int]]())
    
    return result
}

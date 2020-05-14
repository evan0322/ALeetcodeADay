//: [Previous](@previous)

import Foundation

//If i + j == k, then they will be in the bucket k
func findDiagonalOrder(_ matrix: [[Int]]) -> [Int] {
    guard matrix.count > 0 && matrix[0].count > 0 else {
        return [Int]()
    }
    
    var bucket = Array(repeating:[Int](), count: matrix.count + matrix[0].count - 1)
    
    for i in 0..<matrix.count {
        for j in 0..<matrix[i].count {
            var nums = bucket[i + j]
            nums.append(matrix[i][j])
            bucket[i + j] = nums
        }
    }
    
    var result = [Int]()
    
    for i in 0..<bucket.count {
        if i % 2 == 0 {
            var nums = bucket[i]
            result += Array(nums.reversed())
        } else {
            result += bucket[i]
        }
    }
    
    return result
    
    
}

//: [Previous](@previous)

import Foundation


//Dp[i][j]: max square that use matrix[i][j] as bottom right element.
// Only when matrix[i][j - 1] == "1" && matrix[i - 1][j] == "1" && matrix[i - 1][j - 1] == "1", the matrix could grow based on previous matrix
func maximalSquare(_ matrix: [[Character]]) -> Int {
    guard matrix.count > 0, matrix[0].count > 0 else {
        return 0
    }
    
    var dp = Array(repeating:Array(repeating:0, count: matrix[0].count), count:matrix.count)
    
    var result = 0
    
    for i in 0..<matrix.count {
        for j in 0..<matrix[i].count {
            if matrix[i][j] == "0" {
                continue
            }
            
            if i - 1 < 0 || j - 1 < 0 {
                dp[i][j] = 1
            } else {
                if matrix[i][j - 1] == "1" && matrix[i - 1][j] == "1" && matrix[i - 1][j - 1] == "1" {
                    var minVal = min(min(dp[i - 1][j], dp[i - 1][j - 1]), dp[i][j - 1])
                    dp[i][j] = Int(pow(Double(minVal).squareRoot() + 1.0, 2))
                } else {
                    dp[i][j] = 1
                }
            }
            
            result = max(dp[i][j], result)
        }
    }
    
    return result
}

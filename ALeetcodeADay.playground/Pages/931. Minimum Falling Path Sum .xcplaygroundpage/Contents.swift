//: [Previous](@previous)

import Foundation

func minFallingPathSum(_ A: [[Int]]) -> Int {
     guard A.count > 0 && A[0].count > 0 else {
         return 0
     }
     
     var dp = Array(repeating:Array(repeating:Int.max,count:A[0].count), count:A.count)
     
     for j in 0..<dp[0].count {
         dp[0][j] = A[0][j]
     }
     
     for i in 1..<dp.count {
         for j in 0..<dp[i].count {
             if j - 1 >= 0 {
                 dp[i][j] = min(dp[i][j], dp[i - 1][j - 1])
             }
             dp[i][j] = min(dp[i][j], dp[i - 1][j])
             if j + 1 < dp[i].count {
                 dp[i][j] = min(dp[i][j], dp[i - 1][j + 1])
             }
             dp[i][j] += A[i][j]
         }
     }
     
     var minValue = Int.max
     for j in 0..<dp[A.count - 1].count {
         minValue = min(minValue,dp[A.count - 1][j])
     }
     
     return minValue
 }

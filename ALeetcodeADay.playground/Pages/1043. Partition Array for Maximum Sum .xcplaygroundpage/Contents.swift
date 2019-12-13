//: [Previous](@previous)

import Foundation

//DP[i] max sum value from A[0] to A[i]
//We need to find out the relation ship between DP[i] and DP[i - 1]... DP[i - K]
//No the special case where i < j.
func maxSumAfterPartitioning(_ A: [Int], _ K: Int) -> Int {
    
    var dp = Array(repeating:0, count: A.count)
    
    for i in 0..<A.count {
        var curMax = 0
        
        for j in 1...K where i - j + 1 >= 0 {
            curMax = max(curMax, A[i - j + 1])
            dp[i] = max(dp[i], (i - j >= 0 ? dp[i - j] : 0) + curMax * j)
        }
    }
    
    return dp.last!
}

//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    //dp[i] = min(dp[i - 1], dp[i - 2], dp[i - 5]) + 1
    //dp[0] = 0
    /*
    1
    */
    var dp = Array(repeating:Int.max, count:amount + 1)
    dp[0] = 0
    
    for i in 1..<dp.count {
        for coin in coins {
            if i - coin >= 0 {
                dp[i] = min(dp[i], dp[i - coin])
            }
        }
        dp[i] = dp[i] == Int.max ? Int.max : dp[i] + 1
    }
    
    return dp[amount] == Int.max ? -1 : dp[amount]
}

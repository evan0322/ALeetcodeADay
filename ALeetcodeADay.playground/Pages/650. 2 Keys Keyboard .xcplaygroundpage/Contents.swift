//: [Previous](@previous)

import Foundation

//650. 2 Keys Keyboard
func minSteps(_ n: Int) -> Int {
    guard n > 1 else {
        return 0
    }
    
    var dp = [Int](repeating:0, count:n + 1)
    
    for i in 1...n {
        if i == 1 {
            dp[i] = 0
        } else if i == 2 {
            dp[i] = 2
        } else {
            var j = i/2
            while j >= 1 {
                if i % j == 0 {
                    dp[i] = dp[j] + i / j
                    break
                }
                j -= 1
            }
        }
    }
    
    return dp[n]
}

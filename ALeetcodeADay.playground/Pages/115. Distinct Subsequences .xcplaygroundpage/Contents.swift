//: [Previous](@previous)

import Foundation

func numDistinct(_ s: String, _ t: String) -> Int {
    var s = s.map{ String($0) }
    var t = t.map{ String($0) }
    
    var dp = Array(repeating:Array(repeating:0,count:s.count + 1), count:t.count + 1)
    
    //dp[0][X] = 1
    //dp[X][0] = 0
    
    for j in 0..<s.count {
        dp[0][j] = 1
    }
    
    for i in 0..<t.count {
        for j in 0..<s.count {
            if t[i] != s[j] {
                dp[i + 1][j + 1] = dp[i + 1][j]
            } else {
                //dp[i][j] : take s[j]
                //dp[i + 1][j]: do not take s[j]
                dp[i + 1][j + 1] = dp[i][j] + dp[i + 1][j]
            }
         }
    }
    
    return dp[t.count][s.count]
    
    
}

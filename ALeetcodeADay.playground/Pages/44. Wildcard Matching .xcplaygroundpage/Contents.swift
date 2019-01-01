//: [Previous](@previous)

import Foundation


//44. Wildcard Matching

func isMatch(_ s: String, _ p: String) -> Bool {
    if p.count == 0 {
        return s.count == 0
    } else if s.count == 0 {
        for char in p {
            if char != "*" {
                return false
            }
        }
        
        return true
    }
    
    var s = s.map{ String($0) }
    var p = p.map{ String($0) }
    
    var dp = [[Bool]](repeating:[Bool](repeating:false, count:p.count + 1), count:s.count + 1)
    
    //DP[i][j] if first i chars in s matches first j chars in p
    
    dp[0][0] = true
    
    for i in 1...s.count {
        dp[i][0] = false
    }
    
    for j in 1...p.count {
        if p[j - 1] == "*" {
            dp[0][j] = dp[0][j - 1]
        }
    }
    
    for i in 1...s.count {
        for j in 1...p.count {
            if (s[i - 1] == p[j - 1] || p[j - 1] == "?") && dp[i - 1][j - 1] {
                dp[i][j] = true
            } else if p[j - 1] == "*" {
                dp[i][j] = dp[i - 1][j] || dp[i][j - 1]
            }
        }
    }
    
    return dp[s.count][p.count]
}

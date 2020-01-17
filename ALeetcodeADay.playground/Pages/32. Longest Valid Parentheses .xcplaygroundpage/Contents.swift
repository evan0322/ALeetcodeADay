//: [Previous](@previous)

import Foundation

/*
dp[i] longest parentheses that ends at i

if s[i]  is (  set dp[i] to 0 as any s ends with ( cannot be valid
if s[i] is )
   if s[i - 1] is ( then s[i] = s[i - 2] + 2
   if s[i - 1] is )
        // ()(())
        // 020026
        if s[i - 1 - s[i - 1]] is ( then s[i] = s[i - 1] + 2 + s[i - 2 - s[i - 1]]
*/

func longestValidParentheses(_ s: String) -> Int {
    
    
    guard s.count > 1 else {
        return 0
    }
    
    var s = s.map{String($0)}
    var dp = Array(repeating:0, count: s.count)
    var result = 0
    
    for i in 1..<s.count {
        if s[i] == ")" {
            if s[i - 1] == "(" {
                dp[i] = (i - 2 > 0 ? dp[i - 2] : 0) + 2
                result = max(result,dp[i])
            } else {
                if i - 1 - dp[i - 1] >= 0 && s[i - 1 - dp[i - 1]] == "(" {
                    dp[i] = dp[i - 1] + 2 +  (i - 2 - dp[i - 1] >= 0 ? dp[i - 2 - dp[i - 1]] : 0)
                    result = max(result,dp[i])
                }
            }
        }
    }
    
    return result
    
    
}

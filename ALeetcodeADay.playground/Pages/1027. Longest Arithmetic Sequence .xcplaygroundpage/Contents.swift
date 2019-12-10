//: [Previous](@previous)

import Foundation


//DP:  dp[i][j] max length of ar sequance with j diff at index i

func longestArithSeqLength(_ A: [Int]) -> Int {
    guard A.count > 0 else {
        return 0
    }
    
    //dp[i][j] max length of ar sequance with j diff at index i
    var dp = [Int:[Int:Int]]()
    var maxLength = 1
    
    
    for m in 0..<A.count {
        dp[m] = [Int:Int]()
        for n in 0..<m where A[n] != A[m]{
            let diff = A[m] - A[n]
            if let diffs = dp[n], let count = diffs[diff] {
                dp[m]![diff] = max(count + 1, dp[n]![diff, default:1])
            } else {
                dp[m]![diff] = 2
            }
            maxLength = max(dp[m]![diff]!, maxLength)
        }
    }
    
    
    
    return maxLength
}

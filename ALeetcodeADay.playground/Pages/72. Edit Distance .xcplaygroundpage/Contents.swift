//: [Previous](@previous)

import Foundation


//Typical dynamic programming.
/*
 We define dp[i][j] as, the min number of operation that is required to change first i character in word1 to first j character to word j.
 
if word1[i - 1] == word2[j - 1] (note that i,j starts from 1) then we do not need to change the string, dp[i][j] = dp[i - 1][j - 1].
 
if word1[i - 1] != word2[j - 1], then we need to find the min of dp[i - 1][j - 1], dp[i - 1][j], dp[i][j - 1], then plus one
 */
func minDistance(_ word1: String, _ word2: String) -> Int {
    
    var word1 = word1.map{String($0)}
    var word2 = word2.map{String($0)}
    
    var dp = Array(repeating:Array(repeating:0, count:word2.count + 1), count:word1.count + 1)
    
    for i in 0...word1.count {
        for j in 0...word2.count {
            if i == 0 && j == 0 {
                dp[i][j] = 0
            } else if i == 0 {
                dp[i][j] = j
            } else if j == 0 {
                dp[i][j] = i
            } else {
                if word1[i - 1] == word2[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1]
                } else {
                    dp[i][j] = min(min(dp[i - 1][j - 1], dp[i - 1][j]), dp[i][j - 1]) + 1
                }
            }
        }
    }
    
    return dp[word1.count][word2.count]
}

//: [Previous](@previous)

import Foundation


func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
    // We know the fact that the knight will always reaches P with heath 1.
    // We calculate backwards to see the minimum value that reaches (0, 0)
    // cur =  min(dp[i + 1][j], dp[i][j + 1]) - dungeon[i][j]
    // if dp[i][j] = cur <= 0 ? 1 : cur
    
    var dp = Array(repeating:Array(repeating:0, count: dungeon[0].count), count:dungeon.count)
    var m = dungeon.count
    var n = dungeon[0].count
    
    
    for i in (0..<m).reversed(){
        for j in (0..<n).reversed() {
            var cur = 0
            if i + 1 == m && j + 1 == n {
                dp[i][j] = dungeon[i][j] < 0 ? -dungeon[i][j] + 1 : 1
            } else {
               if i + 1 < m && j + 1 < n {
                   cur =  min(dp[i + 1][j], dp[i][j + 1]) - dungeon[i][j]
               } else if i + 1 < m {
                   cur = dp[i + 1][j] - dungeon[i][j]
               } else {
                   cur = dp[i][j + 1] - dungeon[i][j]
               }
               
               dp[i][j] = cur <= 0 ? 1 : cur
           }
               
            
        }
    }
    
    return dp[0][0]
}

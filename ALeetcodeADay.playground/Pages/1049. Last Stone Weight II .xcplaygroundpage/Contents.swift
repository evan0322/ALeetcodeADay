//: [Previous](@previous)

import Foundation

/*
   Divide the nums into two groups and make the diff minimal
   Sm + Sn = S
   Sm - Sn = diff ->
   
   diff = S - 2Sn ->
   
   find the max value of Sn that does not exceed S/2 ->
   
   knapsack problem
 
   dp[i][j] -> able to sum to j with element in 0...i
   dp[i][j] = dp[i - 1][j - num[i - 1]] || dp[i - 1]
   */
func lastStoneWeightII(_ stones: [Int]) -> Int {
       let sum = stones.reduce(0, +)
       
       
       var dp = Array(repeating:Array(repeating:false, count:sum/2 + 1), count: stones.count + 1)
       dp[0][0] = true
       
       for i in 1...stones.count {
           for j in 0...sum/2 {
               if j >= stones[i - 1] {
                   dp[i][j] = dp[i - 1][j - stones[i - 1]] || dp[i - 1][j]
               } else {
                   dp[i][j] = dp[i - 1][j]
               }
           }
       }
       
       var minValue = Int.max
       
       for j in 0...sum/2 {
           if dp[stones.count][j] {
               minValue = min(minValue, sum - j * 2)
           }
       }
       
       return minValue
       
   }

// We can see that dp[i][x] only relate to dp[i - 1][x]. so we just need one array to remember previous calculated value
 func lastStoneWeightIILessSpace(_ stones: [Int]) -> Int {
    let sum = stones.reduce(0, +)
    
     
    var dp = Array(repeating:false, count: sum/2 + 1)
     dp[0] = true
    
    for i in 1...stones.count {
        var temp = Array(repeating:false, count: sum/2 + 1)
        for j in 0...sum/2 {
            if j >= stones[i - 1] {
                temp[j] = dp[j - stones[i - 1]] || dp[j]
            } else {
                temp[j] = dp[j]
            }
        }
        dp = temp
    }
    
    var minValue = Int.max
    
    for j in 0...sum/2 {
        if dp[j] {
            minValue = min(minValue, sum - j * 2)
        }
    }
    
    return minValue
    
}

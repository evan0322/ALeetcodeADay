//: [Previous](@previous)

import Foundation

//740. Delete and Earn
/*
 This is similar to 198. House Robber.
 But instead of restriction to take adjacent element, the restriction is on taking
 Adjacent element value.
 So we create a bucket with 10001 slot. We fill in the slot based on the fact that
 if dp[i] is taken, then dp[i - 1] cannot be taken.
 
 dp[i] = max(dp[i - 2] + val, dp[i - 1])
 
 dp[i], the max value of the earn, if we take num i from the nums array
 
 */
 func deleteAndEarn(_ nums: [Int]) -> Int {
     guard nums.count > 0 else {
         return 0
     }
    
     
     var memo = [Int:Int]()
     var maxNum = 0
     
     for num in nums {
         memo[num] = memo[num, default:0] + num
         maxNum = max(maxNum,num)
     }
             
     
     var dp = Array(repeating:0, count:maxNum + 1)
     
     for i in 1..<dp.count {
         if memo[i] == nil {
             //Note here if i is not in nums, we cannot take it
             dp[i] = dp[i - 1]
         } else {
             if i == 1 {
                 dp[i] = memo[i]!
             } else {
                 if let val = memo[i] {
                     dp[i] = max(dp[i - 2] + val, dp[i - 1])
                 }
             }
         }
     }
     
     return dp.last!
 }
 

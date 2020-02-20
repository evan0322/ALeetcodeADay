//: [Previous](@previous)

import Foundation

func findNumberOfLIS(_ nums: [Int]) -> Int {
     //dp[i]: length of  longest sub sequence that ends at i
     //sCount[i]: number of the longest sub sequence with max length that ends at i
     
     var dp = Array(repeating:1, count:nums.count)
     var sCount = Array(repeating:1, count:nums.count)
     
     var maxSize = 0
     
     for i in 0..<nums.count {
         if i == 0 {
             dp[i] = 1
             sCount[i] = 1
         } else {
             var curMax = 0
             var curCount = 1
             for j in 0..<i where nums[j] < nums[i] {
                 if dp[j] > curMax {
                     curCount = sCount[j]
                     curMax = dp[j]
                 } else if dp[j] == curMax {
                     curCount += sCount[j]
                 }
             }
             dp[i] = curMax + 1
             sCount[i] = curCount
         }
         maxSize = max(maxSize, dp[i])
     }

     var result = 0
     
     for i in 0..<dp.count {
         if dp[i] == maxSize {
             result += sCount[i]
         }
     }
     
     return result
     
 }

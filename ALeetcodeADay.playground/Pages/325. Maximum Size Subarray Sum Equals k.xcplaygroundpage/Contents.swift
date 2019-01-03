//: [Previous](@previous)

import Foundation


//325. Maximum Size Subarray Sum Equals k
/*
 Similar to 2 sum.
 let sum[i] be the sum from 0 to i.
 Then we need to find all sum[m] - sum[n] = k
 We traverse through the array while keep track of current sum.
 */
func maxSubArrayLen(_ nums: [Int], _ k: Int) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    
    var sum = 0
    var maxD = 0
    var memo = [Int:Int]()
    
    for i in 0..<nums.count {
        sum += nums[i]
        if sum == k {
            //As we traverse right, current i is always farthest
            maxD = i + 1
        } else if memo[sum - k] != nil {
            maxD = max(i - memo[sum - k]!, maxD)
        }
        
        //We do not want to override the older/farthest one
        if memo[sum] == nil {
            memo[sum] = i
        }
    }
    
    return maxD
}

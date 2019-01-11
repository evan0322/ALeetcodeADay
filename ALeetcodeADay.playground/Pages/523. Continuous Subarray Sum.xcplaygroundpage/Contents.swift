//: [Previous](@previous)

import Foundation

/*
 If sum[0, i] % k has been seen before (for example j), that means sum[0, j] - sum[0, i] = nk
 */
//523. Continuous Subarray Sum

func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {
    guard nums.count > 0 else {
        return false
    }
    
    var sum = 0
    var memo = [Int:Int]()
    memo[0] = -1
    
    for i in 0..<nums.count {
        sum += nums[i]
        let remain = k == 0 ? sum : sum % k
        if let index = memo[remain] {
            if i - index > 1 {
                return true
            }
        }
        if memo[remain] == nil {
            memo[remain] = i
        }
    }
    
    return false
}

//: [Previous](@previous)

import Foundation

var str = "Hello, playground"
/*
 Simiar to maxSubarry, but in this case we have two scenario
 
 [* * * * [Max Sub Array] * * * * ]
 
 [[MSA] * * * * * * * * * [M S A]]]
 
 In the first case, we have result = max(result, Max Sub Array)
 In the second case, we have result = max(result, sum - Min Sub Array)
 Note when the element is all negative, we cannot pick empty array which sums to 0. We choose maxSum instead
 */
func maxSubarraySumCircular(_ A: [Int]) -> Int {
    var dpMax = Array(repeating:0, count:A.count)
    var dpMin = Array(repeating:0, count:A.count)
    var curMax = -30000
    var curMin = 30000
    var sum = 0
    
    var result = A[0]
    
    for i in 0..<A.count {
        if i == 0 {
            dpMax[i] = A[i]
            dpMin[i] = A[i]
        } else {
            dpMax[i] = dpMax[i - 1] >= 0 ? dpMax[i - 1] + A[i] : A[i]
            dpMin[i] = dpMin[i - 1] <= 0 ? dpMin[i - 1] + A[i] : A[i]
        }
        curMax = max(dpMax[i], curMax)
        curMin = min(dpMin[i], curMin)
        sum += A[i]
    }
    
    
    //Corner case when the array is all negative, which means curMax <= 0
    return curMax > 0 ? max(curMax,sum - curMin) : curMax
}

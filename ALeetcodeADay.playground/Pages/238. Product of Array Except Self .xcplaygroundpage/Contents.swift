//: [Previous](@previous)

import Foundation

//No extra space
//In first run, We use result[i] to record the product of nums[0] * ... nums[i - 1]
//In second run, We multiple result with nums[n] * nums[n - 1] ... nums[i + 1]
//238. Product of Array Except Self
func productExceptSelf(_ nums: [Int]) -> [Int] {
    var result = [Int]()
    var p = 1
    for i in 0..<nums.count {
        result.append(p)
        p = p * nums[i]
    }
    
    p = 1
    for i in (0..<nums.count).reversed() {
        result[i] = result[i] * p
        p *= nums[i]
    }
    
    return result
    
}

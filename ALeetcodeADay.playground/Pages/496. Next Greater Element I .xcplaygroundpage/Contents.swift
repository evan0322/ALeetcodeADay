//: [Previous](@previous)

import Foundation

//496. Next Greater Element I 
/*
 The problem can be translate into "find the next largest element for each of the elements in array array nums2"
 Then we can use stack to keep the decreasing order, then once an element is found we can pop the stack until a larger element in the stack is found
 */
func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    guard nums1.count > 0, nums2.count > 0 else {
        return [Int]()
    }
    
    var memo = [Int:Int]()
    var stack = [Int]()
    
    for i in 0..<nums2.count {
        while stack.count != 0 && nums2[stack.last!] < nums2[i] {
            var cur = stack.removeLast()
            memo[nums2[cur]] = nums2[i]
        }
        
        stack.append(i)
    }
    
    
    var result = [Int]()
    for n in nums1 {
        if let num = memo[n] {
            result.append(num)
        } else {
            result.append(-1)
        }
    }
    
    return result
}

//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

/*
 The question can be translate to this:
 let s[i] be the num of sub array that minimal element is A[i], then
 sum = s[0] * A[0] + ... + s[n] * A[n]
 
 So we need to find the index of first larger element on the left  of i (left[i]) and the first element on the right of i (right[i]), then s[i] = left[i] * right[i]
 We can use stack to solve this
 
 Time: O(n)
 */
//907. Sum of Subarray Minimums

func sumSubarrayMins(_ A: [Int]) -> Int {
    guard A.count > 0 else {
        return 0
    }
    
    var mod = 1
    for i in 0..<9 {
        mod *= 10
    }
    mod += 7
    
    var A = [0] + A + [0]
    var stack = [Int]()
    var result = 0
    
    for i in 0..<A.count {
        while stack.count > 0 && A[stack.last!] > A[i] {
            let cur = stack.removeLast()
            result += A[cur] * (cur - stack.last!) * (i - cur)
        }
        stack.append(i)
    }
    return result%mod
}

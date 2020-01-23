//: [Previous](@previous)

import Foundation

//Use stack
func findPermutation(_ s: String) -> [Int] {
    guard s.count > 0 else {
        return [Int]()
    }
    
    var stack = [Int]()
    var result = Array(repeating:0, count:s.count + 1)
    var cur = 1
    
    var s = s.map{String($0)}
    s.append("I")
    
    for i in 0..<s.count {
        if s[i] == "D" {
            stack.append(i)
        } else {
            result[i] = cur
            cur += 1
            while stack.count != 0 {
                let j = stack.removeLast()
                result[j] = cur
                cur += 1
            }
        }
    }
    
    return result
}

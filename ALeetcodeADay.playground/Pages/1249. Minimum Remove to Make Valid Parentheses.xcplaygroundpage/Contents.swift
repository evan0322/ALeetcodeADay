//: [Previous](@previous)

import Foundation
/*
  Go through the string to find the invalid ")". record "(" with stack. If there is still any "(" after the loop, then these indexes are also invalid. Remove all of them from the original string.
  */
func minRemoveToMakeValid(_ s: String) -> String {
    var stack = [Int]()
    
    var s = s.map{String($0)}
    var invalid = Set<Int>()
    
    for i in 0..<s.count {
        if s[i] == "(" {
            stack.append(i)
        } else if s[i] == ")" {
            if stack.count == 0 {
                invalid.insert(i)
            } else {
                stack.removeLast()
            }
        }
    }
    
    for index in stack {
        invalid.insert(index)
    }
    
    var result = [String]()
    
    for i in 0..<s.count {
        if !invalid.contains(i) {
            result.append(s[i])
        }
    }
    
    return result.joined()
    
    
}

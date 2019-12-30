//: [Previous](@previous)

import Foundation

func removeDuplicates(_ S: String) -> String {
    
    let s = S.map{String($0)}
    var stack = [String]()
    var pre = ""
    
    for char in s {
        if stack.count == 0 {
            stack.append(char)
        } else {
            let pre = stack.last!
            if char != pre {
                stack.append(char)
            } else {
                stack.removeLast()
            }
        }
    }

    return stack.joined()
}

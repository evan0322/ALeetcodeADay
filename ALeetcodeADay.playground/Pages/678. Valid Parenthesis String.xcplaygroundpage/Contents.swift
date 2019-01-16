//: [Previous](@previous)

import Foundation

/*
 678. Valid Parenthesis String
 Samilar to check if the string is valid parenthesis. Since we have "*" here, we could check the range instead of the count. User count[0] as lower bound, count[1] as uppoer bound. As long as the upper not lower than 0, and lower is equal to 0, we find a valid paraenthesis
 */
func checkValidString(_ s: String) -> Bool {
    guard s.count > 0 else {
        return true
    }
    var s = s.map{ String($0) }
    var count = [0, 0]
    
    for i in 0..<s.count {
        if s[i] == "(" {
            count[0] += 1
            count[1] += 1
        } else if s[i] == ")" {
            if count[0] > 0 {
                count[0] -= 1
            }
            count[1] -= 1
        } else if s[i] == "*" {
            if count[0] > 0 {
                count[0] -= 1
            }
            count[1] += 1
        }
        
        if count[1] < 0 {
            return false
        }
    }
    
    return count[0] == 0
}

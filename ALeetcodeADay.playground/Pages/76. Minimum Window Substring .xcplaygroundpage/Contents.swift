//: [Previous](@previous)

import Foundation

//76. Minimum Window Substring

// This is similar to all the other sub string problem.
   //We have two pointer start and end, first we move end until a valid string is find.
   //Then move start until the string is invalid. Then move the end until the string is valid again.
   //The key here is that while you are moving the i, you keep check the result and current i...j sub string until we find an invalid sub string. remember checking does not cost anything
func minWindow(_ s: String, _ t: String) -> String {
    let s = s.map{ String($0) }
    let t = t.map{ String($0) }
    
    guard s.count > 0 && t.count > 0 && t.count <= s.count else {
        return ""
    }
    
    var memo = [String: Int]()
    var count = t.count
    
    for char in t {
        memo[char] = memo[char, default:0] + 1
    }
    
    var result = [String]()
    var i = 0
    var j = 0
    
    while j < s.count {
        if var c = memo[s[j]] {
            c -= 1
            memo[s[j]] = c
            if c >= 0 {
                count -= 1
            }
        }
        
        while count == 0 {
            if result.count == 0 {
                result = Array(s[i...j])
            } else {
                result = result.count > j - i + 1 ? Array(s[i...j]) : result
            }
            
            if var c = memo[s[i]] {
                c += 1
                if c > 0 {
                    count += 1
                }
                memo[s[i]] = c
            }
            i += 1
        }
        j += 1
    }
    
    return result.joined()
}

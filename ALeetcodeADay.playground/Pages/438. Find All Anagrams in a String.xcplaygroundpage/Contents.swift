//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//438. Find All Anagrams in a String
//Sliding window
func findAnagrams(_ s: String, _ p: String) -> [Int] {
    guard s.count > 0, p.count > 0, p.count <= s.count else {
        return [Int]()
    }
    
    var s = s.map{String($0)}
    var p = p.map{String($0)}
    
    
    let window = p.count
    var i = 0
    var j = 0
    var required = p.count
    var memo = [String:Int]()
    var result = [Int]()
    
    for char in p {
        memo[char] = memo[char, default:0] + 1
    }
    
    while j < s.count {
        if var count = memo[s[j]] {
            count -= 1
            if count >= 0 {
                required -= 1
            }
            memo[s[j]] = count
        }
        
        if j - i >= window {
            if var count = memo[s[i]] {
                count += 1
                if count  > 0 {
                    required += 1
                }
                memo[s[i]] = count
            }
            i += 1
        }
        
        if required == 0 {
            result.append(i)
        }
        
        j += 1
    }
    
    return result
}

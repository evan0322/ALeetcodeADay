//: [Previous](@previous)

import Foundation

//Sliding window
//O(n)
func lengthOfLongestSubstringKDistinct(_ s: String, _ k: Int) -> Int {
    
    guard k > 0, s.count > 0 else {
        return 0
    }
    //Sliding window
    let s = s.map{ String($0) }
    var maxLength = 0
    
    var memo = [String:Int]()
    
    var i = 0
    var j = 0
    
    //Slide J until the critiria does not meet
    while j < s.count {
        memo[s[j]] = memo[s[j], default:0] + 1
        
        
        //Slide I until the critiria is met again
        while i < j && memo.keys.count > k {
            if var count = memo[s[i]] {
                count -= 1
                if count == 0 {
                    memo[s[i]] = nil
                }  else {
                    memo[s[i]] = count
                }
            }
            i += 1
        }
        
        //Always update the result when the critiria is valid
        maxLength = max(maxLength,j - i + 1)
        j += 1
    }
    
    return maxLength
}

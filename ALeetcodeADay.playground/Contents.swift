//: Playground - noun: a place where people can play

import UIKit

class Solution {
    
    // No.14 Longest Common Prefix
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 0 else {
            return ""
        }
        var common = ""
        for i in 0...Int.max {
            guard let currentCommon = strs.first!.stringAtIndex(index: i) else {
                return common
            }
            for string in strs {
                if i >= string.count || string.stringAtIndex(index: i) != currentCommon {
                    return common
                }
            }
            common = common + currentCommon
            }
        return common
    }
    
    //Fasteest answer.
    //Instead of starting at the begin of the string then adding up, the function keep deleting the first string until all the string contains the
    //Trimed string
    /*
     func longestCommonPrefix(_ strs: [String]) -> String {
     
         guard !strs.isEmpty else {
             return ""
         }
         var prefix = strs[0]
         for index in 1..<strs.count {
             while !strs[index].hasPrefix(prefix) {
                 prefix = String(prefix.dropLast())
             }
         }
     
         return prefix
     }
     */
    
    
    // No.20 Valid Parentheses
    func isValid(_ s: String) -> Bool {
            var string = s
            var expectedEndings = ""
        
            while !string.isEmpty {
                let currentChar = String(string.prefix(1))
                switch currentChar {
                case "(", "{", "[":
                    expectedEndings += currentChar
                case ")":
                    if expectedEndings.isEmpty || String(expectedEndings.suffix(1)) != ")" {
                        return false
                    }
                    expectedEndings = String(expectedEndings.dropLast())
                case "}":
                    if expectedEndings.isEmpty || String(expectedEndings.suffix(1)) != "}" {
                        return false
                    }
                    expectedEndings = String(expectedEndings.dropLast())
                case "]":
                    if expectedEndings.isEmpty || String(expectedEndings.suffix(1)) != "]" {
                        return false
                    }
                    expectedEndings = String(expectedEndings.dropLast())
                default:
                    break
                }
                string = String(string.dropFirst())
            }
        
            return expectedEndings.isEmpty
    }
    
    // 28. Implement strStr()
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.count > haystack.count {
            return -1
        }
        
        var tempString = haystack
        
        for i in 0...(haystack.count - needle.count) {
            if String(tempString.prefix(needle.count)) == needle {
                return i
            } else {
                tempString = String(tempString.dropFirst())
            }
        }
        return -1
    }
    
    //3. Longest Substring Without Repeating Characters
    //Brutal force
    //    func lengthOfLongestSubstring(_ s: String) -> Int {
    //        var longest = ""
    //        for i in 0..<s.count {
    //            for j in i..<s.count {
    //                let currentString = String(Array(s)[i...j])
    //                if allUnique(string: currentString) && currentString.count>longest.count {
    //                    longest = currentString
    //                }
    //            }
    //        }
    //        return longest.count
    //    }
    //
    //    func allUnique(string: String) -> Bool {
    //        let char = Array(string)
    //        return Set(char).count == char.count
    //    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        //Sliding window
        
        if s.count < 2 {
            return s.count
        }
        
        var i = 0
        var j = 0
        var longest = 0
        var sArray = Array(s)
        
        
        while i < s.count && j < s.count {
            for k in i...j {
                if sArray[k] == sArray[j] {
                    i = k + 1
                    if j - i + 1 > longest {
                        longest = j - i + 1
                    }
                    break
                }
            }
            j += 1
        }
        return max(longest - 1, j - i)
    }
    
    
    // 171. Excel Sheet Column Number
    func titleToNumber(_ s: String) -> Int {
        var string = Array(s.uppercased())
        var dict = [Character: Int]()
        
        let charArray = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        for i in 0..<charArray.count {
            dict[charArray[i]] = i + 1
        }
        
        var i = 1
        var ans = 0
        while !string.isEmpty {
            let char = string.last!
            ans += dict[char]!*i
            i = i*26
            string = Array(string.dropLast())
        }
        return ans
    }
}

let solution = Solution()


extension String {
    func stringAtIndex(index: Int) -> String? {
        guard index < self.count else {
            return nil
        }
        let stringArray = Array(self)
        return String(stringArray[index])
    }
    
    func stringFrom(index:Int, toIndex:Int) -> String? {
        if index >= self.count || toIndex >= self.count || toIndex < index {
            return nil
        }
        return String(Array(self)[index...toIndex])
    }
}


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
    
    //39. Combination Sum. use depth first search. Use [2, 3, 6, 7] as an example. 2's neighbor is 2, 3, 6, 7. Visit these nodes until the target - current  < 0, then return.
    
    var result = [[Int]]()
    
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        if candidates.count == 0 {
            return [[]]
        } else {
            candidates.sorted(by: {$0 < $1})
            candidates
            findCombineSum(array: candidates, target: target, index: 0, path: [Int]())
        }
        return result
    }
    
    
    func findCombineSum(array:[Int], target: Int, index: Int, path: [Int]) {
        if target == 0 {
            result.append(path)
            print("append")
            return
        } else if target < 0 {
            return
        } else {
            for i in index..<array.count {
                print(path)
                findCombineSum(array: array, target: target - array[i], index: i, path: path + [array[i]])
            }
        }
    }
    
    //78 Subsets Similar to 39. Contruct a depth-first tree the the rules: Let's say [1,2,3]. Start with empty array, with children 1, 2, 3, then 1 has children 2,3. 2 has child 3. 3 has no child. We visit each node an put the path to the result (Unlike 39, with only logs when reaches the leaf). Then for each children for current node, we continue to explore.
    var subsetsResult = [[Int]]()
    
    func subsets(_ nums: [Int]) -> [[Int]] {
        
        func explore(array: [Int], index: Int, path: [Int]) {
            if index == array.count {
                return
            } else {
                for i in index..<array.count {
                    subsetsResult.append(path + [array[i]])
                    explore(array: array, index: i + 1, path: path + [array[i]])
                }
            }
        }
        
        
        explore(array: nums, index: 0, path: [Int]())
        
        return subsetsResult + []
        
    }
    
    //387. First Unique Character in a String O(2N)
    func firstUniqChar(_ s: String) -> Int {
        var harshTable = [Character: Int]()
        for char in Array(s) {
            if let count = harshTable[char] as? Int {
                harshTable[char] = count + 1
            } else {
                harshTable[char] = 1
            }
        }
        
        for i in 0..<s.count {
            if let count = harshTable[Array(s)[i]] as? Int {
                if count == 1 {
                    return i
                }
            }
        }
        
        return -1
    }
    
    
    //583. Delete Operation for Two Strings
    //Use memory to reduce the time complexity. reduce from 2^max(m,n) to m*n
    var memo = Array(repeating:Array(repeating: -1, count:500), count:500)
    
    func minDistance(_ word1: String, _ word2: String) -> Int {
        return word1.count + word2.count - 2 * lcsCount(word1: Array(word1), m: word1.count - 1, word2: Array(word2), n: word2.count - 1)
    }
    
    func lcsCount(word1:[Character], m:Int, word2:[Character], n:Int) -> Int {
        if m < 0 || n < 0  {
            return 0
        } else if memo[m][n] != -1 {
            return memo[m][n]
        } else if word1[m] == word2[n] {
            return 1 + lcsCount(word1:word1, m:m - 1, word2: word2, n:n - 1)
        } else {
            memo[m][n] = max(lcsCount(word1:word1, m:m, word2:word2, n:n - 1), lcsCount(word1: word1, m: m - 1, word2:word2, n: n))
            return memo[m][n]
        }
    }
    
    //5. Longest Palindromic Substring
    //Use memory to reduce the time complexity. the time complextity is 2N * N/2 = N^2
    
    var memo = [String: String]()
    
    func longestPalindrome(_ s: String) -> String {
        let result = palindrom(s: Array(s), i: 0, j: s.count - 1)
        return String(result)
    }
    
    func palindrom(s: [Character], i: Int, j: Int) -> [Character] {
        if i == j {
            return [s[i]]
        } else if let memory = memo[String(Array(s[i...j]))] {
            return Array(memory)
        } else if isPalindrome(s:Array(s[i...j])) == true {
            return Array(s[i...j])
        } else {
            let s1 = palindrom(s: s, i: i + 1, j: j)
            let s2 = palindrom(s: s, i: i, j: j - 1)
            if s1.count > s2.count {
                memo[String(Array(s[i...j]))] = String(s1)
                return s1
            } else {
                memo[String(Array(s[i...j]))] = String(s2)
                return s2
            }
        }
    }
    
    func isPalindrome(s: [Character]) -> Bool {
        if s.count == 0 {
            return true
        } else {
            for i in 0..<s.count/2 {
                if s[i] != s[s.count - 1 - i] {
                    return false
                }
            }
            return true
        }
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


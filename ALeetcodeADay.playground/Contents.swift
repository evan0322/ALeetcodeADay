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
    
    
    // 337. Combination Sum IV
    // For DP questions, we need to give a precise equation of the relation ship between n and n - x.
    // For example, in this case
    // let nums = [a1, a2, ... , an], target = t
    // then c(nums, t) = c(nums, t-a1) + c(nums, t-a2) +...+c(nums,t-an)
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        var memo = Array(repeating: -1, count: target + 1)
        func helper(nums: [Int], target: Int) -> Int {
            if target == 0 {
                return 1
            } else if target < 0 {
                return 0
            } else if memo[target] != -1 {
                return memo[target]
            } else {
                var count = 0
                for num in nums {
                    count += helper(nums: nums, target: target - num)
                }
                memo[target] = count
                return count
            }
        }
        return helper(nums: nums, target: target)
    }
    
    //322. Coin Change Similar recursive problem. This tricky because the relationship between f(n) and f(n-1) is complecated.
    // let nums = [a1, a2, ... , an], target = t
    //f(t) = min(f(t-a1), f(t-a2), f(t-a3),...,f(t-an)) where f(t-ax) > 0
    //So just take whatever the return value from f(t-ax) is then perform the logic check.
    // The key is pretend that you already know the result of f(t-ax)!
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        var memo = Array(repeating: -100, count: amount + 1)
        
        func helper(coins: [Int], amount: Int) -> Int {
            if amount == 0 {
                return 0
            } else if amount < 0 {
                return -1
            } else if memo[amount] != -100 {
                return memo[amount]
            } else {
                var min = Int.max
                for coin in coins {
                    var current = 0
                    let temp = helper(coins: coins, amount: amount - coin)
                    if temp >= 0 {
                        current = temp + 1
                    }
                    
                    if current > 0 && current < min {
                        min = current
                    }
                }
                
                let result = min == Int.max ? -1 : min
                memo[amount] = result
                return result
            }
            
        }
        
        return helper(coins: coins, amount: amount)
    }
    
    // 300 Longest Increasing Subsequence review this with binary search
    // https://leetcode.com/problems/longest-increasing-subsequence/solution/
    func lengthOfLIS(_ nums: [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count
        }
        
        var memo = Array(repeating: 1, count: nums.count)
        var maxLIS = 1
        func lis(nums:[Int], index:Int) -> Int {
            if index == nums.count {
                return maxLIS
            } else if memo[index] > 1 {
                return memo[index]
            } else {
                for i in 0...index {
                    if nums[i] < nums[index] {
                        memo[index] = max(memo[index], memo[i] + 1)
                        maxLIS = max(memo[index], maxLIS)
                    }
                }
                return lis(nums: nums, index: index + 1)
            }
        }
        
        return lis(nums: nums, index: 0)
    }
    
    //62. Unique Paths
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var memo = Array(repeating: Array(repeating: -1, count:n + 1), count: m + 1)
        func findUniqueP(m: Int, n: Int) -> Int {
            if m < 0 || n < 0 {
                return 0
            } else if m == 1 && n == 1 {
                return 1
            } else if memo[m][n] != -1 {
                return memo[m][n]
            } else {
                memo[m][n] = findUniqueP(m:m-1, n:n) + findUniqueP(m:m, n:n-1)
                return memo[m][n]
            }
        }
        
        return findUniqueP(m: m, n: n)
    }
    
    //64. Minimum Path Sum: Similar question to 62
    func minPathSum(_ grid: [[Int]]) -> Int {
        if grid.count == 0 || grid.first == nil {
            return -1
        }
        var memo = Array(repeating: Array(repeating: -1, count: grid.first!.count), count: grid.count)
        
        func minSum(m: Int, n: Int) -> Int {
            if m < 0 || n < 0 {
                return Int.max
            } else if m == 0 && n == 0 {
                return grid[0][0]
            } else if memo[m][n] != -1 {
                return memo[m][n]
            } else {
                memo[m][n] = grid[m][n] + min(minSum(m:m - 1, n:n), minSum(m:m, n:n - 1))
                return memo[m][n]
            }
        }
        return minSum(m:grid.count - 1, n:grid.first!.count - 1)
    }
    
    //198 House Robber. Recursive, Result is
    func rob(_ nums: [Int]) -> Int {
        
        var memo = Array(repeating: -1, count: nums.count)
        
        func maxUntil(index: Int) -> Int {
            if index < 0 {
                return 0
            } else if index == 1 {
                return max(nums[0], nums[1])
            } else if memo[index] != -1 {
                return memo[index]
            } else {
                memo[index] = max(maxUntil(index:index - 2) + nums[index], maxUntil(index:index - 1))
                return memo[index]
            }
        }
        
        return maxUntil(index: nums.count - 1)
        
    }
    
    // 646. Maximum Length of Pair Chain( sort the array first is the key)

    func findLongestChain(_ pairs: [[Int]]) -> Int {
        var memo = Array(repeating: 1, count: pairs.count)
        let sortedPairs = pairs.sorted(by: {$0.first! < $1.first!})
        
        
        func findChain(index:Int) -> Int {
            if index == 0 {
                return 1
            } else if memo[index] != 1 {
                return memo[index]
            } else {
                var maxChain = 1
                for i in 0..<index {
                    if sortedPairs[index].first! > sortedPairs[i].last! {
                        maxChain = max(maxChain, findChain(index: i) + 1)
                    }
                }
                memo[index] = maxChain
                return maxChain
            }
        }
        
        return findChain(index: sortedPairs.count - 1)
        
    }
    
    //455. Assign Cookies
    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        let sortedG = g.sorted(by:{$0 < $1})
        let sortedS = s.sorted(by:{$0 < $1})
        var i = 0
        var j = 0
        while i < sortedG.count && j < sortedS.count {
            if sortedG[i] <= sortedS[j] {
                i += 1
            }
            j += 1
        }
        
        return i
    }
    
    
    //455. Minimum Number of Arrows to Burst Balloons
    func findMinArrowShots(_ points: [[Int]]) -> Int {
        guard points.count > 0 else {
            return 0
        }
        
        let sortedPoints = points.sorted(by:{$0.first! < $1.first!})
        var common = [0, Int.max]
        var count = 1
        
        for point in sortedPoints {
            if point.first! > common.last! {
                count += 1
                common = point
            } else {
                common = [point.first!, min(point.last!, common.last!)]
            }
        }
        
        return count
    }
    //406. Queue Reconstruction by Height
    //Notice the double sort. Otherwise it will fail
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        var result = [[Int]]()
        let sortedP = people.sorted(by:{
            if $0.first! == $1.first! {
                return $0.last! < $1.last!
            } else {
                return $0.first! > $1.first!
            }
        })
        for i in 0..<sortedP.count {
            result.insert(sortedP[i], at:sortedP[i].last!)
        }
        return Array(result[0..<people.count])
    }
    
    //581. Shortest Unsorted Continuous Subarray
    func findUnsortedSubarray(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        
        var lowIndex = 0
        var highIndex = nums.count - 1
        var find = false
        
        let sortedNums = nums.sorted(by:{$0 < $1})
        
        for i in 0..<nums.count {
            if sortedNums[i] != nums[i] {
                lowIndex = i
                find = true
                break
            }
        }
        
        for i in (0..<nums.count).reversed() {
            if sortedNums[i] != nums[i] {
                highIndex = i
                find = true
                break
            }
        }
        
        return find ? highIndex - lowIndex + 1 : 0
    }
}


//Extra

//Eight queen problem The eight queens puzzle is the problem of placing eight chess queens on an 8×8 chessboard so that no two queens threaten each other. Thus, a solution requires that no two queens share the same row, column, or diagonal. The eight queens puzzle is an example of the more general n queens problem of placing n non-attacking queens on an n×n chessboard, for which solutions exist for all natural numbers n with the exception of n=2 and n=3
typealias chess = (r:Int, c:Int)

let totalSize = 8

var result = [[chess]]()

func isPlacable(chesses:[chess], row: Int) -> Bool {
    for i in 0..<chesses.count {
        if row == chesses[i].r - chesses.count + i ||
            row == chesses[i].r + chesses.count - i ||
            row == chesses[i].r {
            return false
        }
    }
    return true
}


func placeChess(placedChessses:[chess], c: Int) {
    if placedChessses.count == totalSize {
        result.append(placedChessses)
    } else {
        for i in 0..<totalSize {
            if isPlacable(chesses: placedChessses, row: i) {
                let newChesses = placedChessses + [chess(i, c)]
                placeChess(placedChessses: newChesses, c: c + 1)
            }
        }
    }
}


// knapsack. Give n item with values and weights, a backpack with capacity weightLimit. Try to figure out the best solution to pack the backpack with bigest value
// Each item has two states: packed and not packed. If it is packed, the new weight limit will be weightLimit  - weights[index] but value will be increased by values[index]. We need to find the maximum between these two senario


// Following is DP without memo. Complexity 2^n
//func knapsack(weightLimit:Int, weights:[Int], values:[Int], index: Int) -> Int {
//
//    if weightLimit <= 0 || index == 0 {
//        return 0
//    } else {
//        return max(knapsack(weightLimit: weightLimit,
//                            weights: weights,
//                            values: values,
//                            index: index - 1), knapsack(weightLimit: weightLimit  - weights[index],
//                                                        weights: weights,
//                                                        values: values,
//                                                        index: index - 1) + values[index])
//    }
//
//}

//let weights = [20, 10, 30]
//let values = [100, 110, 120]
//let weightLimit = 55
//
//knapsack(weightLimit: weightLimit, weights: weights, values: values, index: values.count - 1)


//placeChess(placedChessses: [chess](), c: 0)




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


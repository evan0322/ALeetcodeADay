//: Playground - noun: a place where people can play

import UIKit

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        
        if self.left == nil && self.right == nil {
            return "\(self.val)"
        } else if self.left == nil {
            return "\(String(self.val)) -> (\(self.right!.description))"
        } else if self.right == nil {
            return "(\(self.left!.description)) <-  \(String(self.val))"
        } else {
            return "(\(left!.description)) <-  \(String(self.val)) -> (\(right!.description))"
        }
    }
}

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
    
    /*
    The follow solustion is the alternative solution for longest increasing subsequence (bottom up)
     We dp should be defined as "d[i]" the longest increasing subsequence that ends with num[i]
     Then we go through each num in nums. With each num, we review all the d[j] that j<i. if nums[i] > nums[j] then numbs[i] can be part of the nums[j] LIS. We also need to keep track on the current max LIS with current i. After the result is finished, then we go through each nums again to find the largest LIS.
     
     BigO = 1 + 2 + 3 .... + n = O(n^2)
    
    */
    func lengthOfLIS_V2(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var dp = Array(repeating: 1, count: nums.count)
        
        dp[0] = 1
        
        for i in 0..<nums.count {
            var currentMax = 1
            for j in 0..<i {
                if nums[i] > nums[j] {
                    currentMax = max(dp[j] + 1, currentMax)
                }
            }
            dp[i] = currentMax
        }
        
        var maxLength = Int.min
        for element in dp {
            maxLength = max(maxLength,element)
        }
        
        return maxLength
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
    // Greed solution. First we sort the array based on the last number. we only put the num that has the smallest last digit into the chain to make the chain as big as possible.
    // O(n) = nlogn (The complexity of sort)

    func findLongestChain(_ pairs: [[Int]]) -> Int {
        if pairs.count <= 1 {
            return pairs.count
        }
        
        var sortedPair = pairs
        sortedPair.sort{ $0[1] < $1[1] }
        
        var count = 0
        var lastNum = Int.min
        for pair in sortedPair {
            if pair[0] > lastNum {
                lastNum = pair[1]
                count += 1
            }
        }
        
        return count
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
    
    //416. Partition Equal Subset Sum
    /*
    This problem is essentially let us to find whether there are several numbers in a set which are able to sum to a specific value (in this problem, the value is sum/2).
    
    Actually, this is a 0/1 knapsack problem, for each number, we can pick it or not. Let us assume dp[i][j] means whether the specific sum j can be gotten from the first i numbers. If we can pick such a series of numbers from 0-i whose sum is j, dp[i][j] is true, otherwise it is false.
    
    Base case: dp[0][0] is true; (zero number consists of sum 0 is true)
    
    Transition function: For each number, if we don’t pick it, dp[i][j] = dp[i-1][j], which means if the first i-1 elements has made it to j, dp[i][j] would also make it to j (we can just ignore nums[i]). If we pick nums[i]. dp[i][j] = dp[i-1][j-nums[i]], which represents that j is composed of the current value nums[i] and the remaining composed of other previous numbers. Thus, the transition function is dp[i][j] = dp[i-1][j] || dp[i-1][j-nums[i]]
     */
    func canPartition(_ nums: [Int]) -> Bool {
        var sum = 0
        for num in nums {
            sum += num
        }
        
        if sum%2 != 0 {
            return false
        }
        
        sum = sum/2
        
        var dp = Array(repeating:Array(repeating:false, count:sum + 1), count: nums.count)
        
        for i in 1..<nums.count {
            dp[i][0] = true
        }
        
        dp[0][0] = true
        
        for i in 1..<nums.count {
            for j in 1...sum {
                if j >= nums[i] {
                    dp[i][j] = dp[i - 1][j]||dp[i - 1][j - nums[i]]
                }
            }
        }
        return dp[nums.count - 1][sum]
    }
    
    
    //520. Detect Capital
    func detectCapitalUse(_ word: String) -> Bool {
        if word == word.uppercased() {
            return true
        } else if word == word.lowercased() {
            return true
        } else {
            var input = word
            let firstLetter = input.removeFirst()
            input = String(firstLetter).uppercased() + input.lowercased()
            return input == word
        }
    }
    
    // 746.  Min Cost Climbing Stairs
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        var dp = Array(repeating:-1 ,count:cost.count + 1)
        
        // dp[n], the final cost of climbing nth stair.
        
        //[1, 100, 1, 1, 1, 100, 1, 1, 100, 1]
        
        dp[0] = cost[0]
        dp[1] = cost[1]
        
        if cost.count < 2 {
            return 0
        } else if cost.count == 2 {
            return min(cost[0], cost[1])
        }
        
        for i in 2..<cost.count {
            dp[i] = cost[i] + min(dp[i - 1], dp[i - 2])
        }
        
        return min(dp[cost.count - 1], dp[cost.count - 2])
    }
    
    //70. Climbing Stairs
    func climbStairs(_ n: Int) -> Int {
        if n < 3 {
            return n
        }
        
        var dp = Array(repeating: -1, count:n + 1)
        dp[0] = 0
        dp[1] = 1
        dp[2] = 2
        
        for i in 3...n {
            dp[i] = dp[i - 1] + dp[i - 2]
        }
        
        return dp[n]
    }
    
    //516. Longest Palindromic Subsequence
    //dp[i][j]: longest palindromic subsequence between index i and index j
    //Note here: the i and j does not nessary represents different context (e.g. index and weight in kpacksack problem). In this case it is index of the array
    func longestPalindromeSubseq(_ s: String) -> Int {
        var dp = Array(repeating: Array(repeating: 0, count: s.count + 1), count: s.count + 1)
        if s.count < 2 {
            return s.count
        }
        
        let sArray = s.map{ String($0) }
        
        //Initial state
        for i in 0..<dp.count {
            dp[i][i] = 1
        }
        
        
        //This is the tricky part. If you traverse from i in 0...s.count - 1 and j in 0...s.count - 1, you will soon find that sometimes dp[i][j] cannot be calculated because dp[i + 1][j] or dp[i][j - 1] is not calculated yet. However if you traverse in this sequnce it will work. I guess you have to try different combination before you choose your way to build up the dp.
        for i in (0...s.count - 2).reversed() {
            for j in i + 1..<s.count{
                if sArray[i] == sArray[j] {
                    // This is hard to think. 
                    dp[i][j] = dp[i + 1][j - 1] + 2
                } else {
                    dp[i][j] = max(dp[i + 1][j], dp[i][j - 1])
                }
            }
        }
        return dp[0][s.count - 1]
    }
    
    //494. Target Sum
    // In this problem, the hard part is how to translate the problem into our known question.
    // We assume that we have a group of num Sp with positive symbol and Sn with negative symbol.
    // Sp - Sn = t
    // Sp - Sn + Sp + Sn = t + Sp + Sn
    // Sp = (t + Sum(nums))/2
    // The question then translate: find the num of ways that construct a sub set of S so that sum[sub] == (t + Sum(nums))/2
    //Then it becomes 1-0 knapsack problem.
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        //NOTE: This is probably working it will fail on large test cases. However the O(n) is S*nums
        // And it is probably fastest. I believe it is due to swift as a none-script language.
        var sum = 0
        
        for num in nums {
            sum += num
        }
        
        if S > sum ||  (sum + S)%2 != 0 {
            return 0
        }
        
        
        
        let target = (sum + S)/2
        
        var dp = Array(repeating:Array(repeating:0, count: target + 1), count:nums.count + 1)
        
        dp[0][0] = 1
        
        for j in 1..<dp[0].count {
            dp[0][j] = 0
        }
        
        for i in 1..<dp.count {
            dp[i][0] = 1
        }
        
        for i in 1..<dp.count {
            for j in 0..<dp[0].count {
                if nums[i - 1] == 0 {
                    dp[i][j] = dp[i - 1][j] * 2
                } else if j > nums[i - 1] || j == nums[i - 1] {
                    dp[i][j] = dp[i - 1][j - nums[i - 1]] + dp[i - 1][j]
                } else {
                    dp[i][j] = dp[i - 1][j]
                }
            }
        }
        return dp[nums.count][target]
    }
    
   // 859. Buddy Strings
    func buddyStrings(_ A: String, _ B: String) -> Bool {
        
        if A.count != B.count {
            return false
        }
        
        let aArray = A.map{ String($0) }
        let bArray = B.map{ String($0) }
        
        var diffs = [String]()
        var dups = [String: Int]()
        
        for i in 0..<A.count {
            if aArray[i] != bArray[i] {
                diffs.append(aArray[i])
                diffs.append(bArray[i])
                if diffs.count > 4 {
                    return false
                }
            } else {
                if let count = dups[aArray[i]] {
                    dups[aArray[i]] = count + 1
                    if count + 1 == 2 {
                        return true
                    }
                } else {
                    dups[aArray[i]] = 1
                }
            }
        }
        if diffs.count == 4 {
            return (diffs[0] == diffs[3] && diffs[1] == diffs[2])
        }  else {
            return false
        }
        
    }
    
    
    //368. Largest Divisible Subset
    /* Similar to #LIS problem
 
     */
    func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        if nums.count == 0 {
            return [Int]()
        }
        
        // We sort the array to ensure we did not go backwards
        var sortedNums = nums.sorted()
        
        // dp[i] largest divisible subset ends with num[i]
        var dp = Array(repeating:[Int](), count:sortedNums.count)
        for i in 0..<sortedNums.count {
            dp[i] = [sortedNums[i]]
        }
        
        var totalMax = dp[0]
        
        //Be careful about the index,
        for i in 1..<sortedNums.count {
            //Becareful here, max is at least dp[i] not [Int]()
            var max = dp[i]
            for j in 0..<i {
                // If a numb and divd the last in the list , it can divide each one of them.
                // Added it to the largest list and compare.
                if sortedNums[i] % dp[j].last! == 0 {
                    let temp = dp[j] + [sortedNums[i]]
                    max = max.count > temp.count ? max : temp
                }
            }
            dp[i] = max
            totalMax = totalMax.count > dp[i].count ? totalMax : dp[i]
        }
        
        return totalMax
    }
    
    // 647. Palindromic Substrings
    func countSubstrings(_ s: String) -> Int {
        if s.count == 0 {
            return 0
        }
        
        let sArray = s.map{ String($0) }
        
        //dp[i][j]: If the subString s[i...j] is palindromic string
        //The tricky part is not to directly set d[i][j] to the num of palindromic string between s[i...j]
        //Because it is very difficult to find the state equation in that case.
        var dp = Array(repeating:Array(repeating:false, count: sArray.count), count:sArray.count)
        var count = 0
        for i in (0..<sArray.count).reversed() {
            for j in i..<sArray.count {
                if sArray[i] == sArray[j] {
                    
                    if j - i < 3 {
                        print("\(i) \(j) are the same")
                        
                        dp[i][j] = true
                    } else {
                        dp[i][j] = dp[i + 1][j - 1]
                    }
                }
                if dp[i][j] {
                    count += 1
                }
            }
        }
        return count
    }
    
    //203. Remove Linked List Elements
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let fakeNode = ListNode(-1)
        fakeNode.next = head
        
        var currentNode: ListNode? = fakeNode
        
        while currentNode != nil {
            if currentNode!.next?.val == val {
                currentNode!.next = currentNode!.next?.next
            }
            currentNode = currentNode!.next
        }
        
        return fakeNode.next
        
        
    }
    
    //387. First Unique Character in a String

    func firstUniqChar(_ s: String) -> Int {
        var countDict = [String: Int]()
        var stringArray = s.map{ String($0) }
        
        for char in stringArray {
            if let count = countDict[char] {
                countDict[char] = count + 1
            } else {
                countDict[char] = 1
            }
        }
        
        for i in 0..<stringArray.count {
            if let finalCount = countDict[stringArray[i]] {
                if finalCount == 1 {
                    return  i
                }
            }
        }
        return -1
    }
    
    //344. Reverse String
    func reverseString(_ s: String) -> String {
        let reversedArray = s.map{ String( $0 ) }
        return reversedArray.reversed().joined()
    }
    
    //22. Generate parenthese
    // Build the string from left to right. Think about the rules that should be applied to the algorithm.
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        func build(index:Int, l: Int, r: Int, current: [String]) {
            if l > r || l < 0 {
                return
            } else if index == n * 2 {
                result.append(current.joined())
                return
            } else {
                build(index:index + 1, l: l - 1, r: r, current: current + ["("])
                build(index:index + 1, l: l, r: r - 1, current: current + [")"])
            }
        }
        
        build(index: 0, l: n, r: n, current: [String]())
        return result
    }
    
    //459.
    
    func repeatedSubstringPattern(_ s: String) -> Bool {
        if s.count == 1 {
            return false
        }
        
        let sArray = s.map{ String($0) }
        for i in 0..<sArray.count/2 where sArray.count%(i + 1) == 0 {
            let repeatingCount = sArray.count/(i + 1)
            var repeatingWholeString = ""
            var repeatingString = sArray[0...i].joined()
            for _ in 1...repeatingCount {
                repeatingWholeString.append(repeatingString)
            }
            
            if repeatingWholeString == s {
                return true
            }
        }
        
        return false
    }
    
    //21 Merge Two sorted link list
    // This could be solved also by iterlary way
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        let fakeNode = ListNode(0)
        
        func merge(l: ListNode?, r: ListNode?, current: ListNode) {
            guard let lCurrent = l else {
                current.next = r
                return
            }
            
            guard let rCurrent = r else {
                current.next = l
                return
            }
            
            if lCurrent.val <= rCurrent.val {
                current.next = ListNode(lCurrent.val)
                return merge(l: lCurrent.next,r: rCurrent, current: current.next! )
            } else {
                current.next = ListNode(rCurrent.val)
                return merge(l: lCurrent,r: rCurrent.next, current: current.next! )
                
            }
        }
        
        merge(l:l1, r:l2, current:fakeNode)
        return fakeNode.next
        
    }
    
    //234.Palindrome Linked List
    
    func isPalindrome(_ head: ListNode?) -> Bool {
        var array = [Int]()
        
        var node = head
        
        while node != nil {
            array.append(node!.val)
            node = node!.next
        }
        
        var i = 0
        while i < array.count/2 {
            if array[i] != array[array.count - i - 1] {
                return false
            }
            i += 1
        }
        return true
    }
    
    //24. Swap Nodes in Pairs
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let fakeHead = ListNode(0)
        fakeHead.next = head
        var p1: ListNode? = fakeHead.next
        var p2: ListNode? = fakeHead.next?.next
        var previous: ListNode? = fakeHead
        while p1 != nil && p2 != nil {
            p1!.next = p2!.next
            p2!.next = p1
            previous!.next = p2
            previous = p1
            p2 = p1!.next?.next
            p1 = p1!.next
            
        }
        return fakeHead.next
    }
    
    //572. Subtree of Another Tree
    func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {

        func isSameTree(t1: TreeNode?, t2: TreeNode?) -> Bool {
            if t1 == nil && t2 == nil {
                return true
            } else if t1 == nil || t2 == nil {
                return false
            } else if t1!.val == t2!.val {
                return isSameTree(t1: t1!.left, t2: t2!.left) && isSameTree(t1: t1!.right, t2: t2!.right)
            } else {
                return false
            }
        }
        
        guard let tTree = t else {
            return true
        }
        
        guard let sTree = s else {
            return false
        }
        
        if isSameTree(t1:tTree, t2: sTree) {
            return true
        }
        
        return isSubtree(sTree.left, tTree) || isSubtree(sTree.right, tTree)
    }
    
    //100. Same Tree
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        } else if p == nil || q == nil {
            return false
        } else if p!.val == q!.val {
            return isSameTree(p!.left, q!.left) && isSameTree(p!.right, q!.right)
        } else {
            return false
        }
    }
    
    //513. Find Bottom Left Tree Value
    //This is a typical example of tree traverse. Be carful to always visit left node first to ensure that the left most is captured
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        var depth = -1
        var helper = [Int: Int]()
        
        func traverse(node: TreeNode?, cDepth: Int) {
            guard let cNode = node else {
                return
            }
            
            if helper[cDepth] == nil && cDepth > depth {
                helper[cDepth] = cNode.val
                depth = cDepth
            }
            
            traverse(node:cNode.left, cDepth:cDepth + 1)
            traverse(node:cNode.right, cDepth:cDepth + 1)
        }
        
        traverse(node: root, cDepth:0)
        return helper[depth]!
    }
    
    
    //257. Binary Tree Paths
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var tPath = [String]()
        
        guard let rootNode = root else {
            return [String]()
        }
        
        func findPath(node: TreeNode, cPath: String) {
            if node.left == nil && node.right == nil {
                tPath.append(cPath + "\(node.val)")
                return
            } else if node.left == nil {
                return findPath(node: node.right!, cPath:cPath + "\(node.val)->")
            } else if node.right == nil {
                return findPath(node: node.left!, cPath:cPath + "\(node.val)->")
            } else {
                findPath(node: node.left!, cPath:cPath + "\(node.val)->")
                findPath(node: node.right!, cPath:cPath + "\(node.val)->")
                return
            }
        }
        
        findPath(node: rootNode, cPath:"")
        return tPath
    }
    
    //105. Construct Binary Tree from Preorder and Inorder Traversal
    
    //This is totally fine runing on the app. however it triggers compiling error on LeetCode.
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if preorder.count == 0 || inorder.count == 0 {
            return nil
        } else if preorder.count == 1 {
            return TreeNode(preorder[0])
        }
        
        let rootNode = TreeNode(preorder[0])
        
        var i = 0
        while i < inorder.count {
            if inorder[i] == rootNode.val {
                break
            }
            i += 1
        }
        
        //Find the first one in preorder, it must be the root of the all the element in the array.
        //Then find the corresponding location in inorder, its left numbers are all its left child and vice versa.
        //Build the tree recursively.
        
        if i == preorder.count {
            rootNode.left = buildTree(Array(preorder[1..<i + 1]), Array(inorder[0..<i]))
            rootNode.right = nil
        } else if i == 0 {
            rootNode.left = nil
            rootNode.right = buildTree(Array(preorder[i + 1..<preorder.count]), Array(inorder[i + 1..<inorder.count]))
        } else {
            rootNode.left = buildTree(Array(preorder[1..<i + 1]), Array(inorder[0..<i]))
            rootNode.right = buildTree(Array(preorder[i + 1..<preorder.count]), Array(inorder[i + 1..<inorder.count]))
        }
        
        return rootNode
    }
    //652. Find Duplicate Subtrees
    // This is a problem actually can be solved by serialize a tree properly. We traverse the tree while getting the serialize presentation of each node, use a dictionary to track if the serialized result exists before.
    
    //The important thing is when you serialize a tree, always use post order or pre order to avaoid confusion
    //https://leetcode.com/problems/find-duplicate-subtrees/discuss/106011/Java-Concise-Postorder-Traversal-Solution
    func findDuplicateSubtrees(_ root: TreeNode?) -> [TreeNode?] {
        var dict = [String: Int]()
        var result = [TreeNode?]()
        
        func traverse(t: TreeNode?) -> String {
            guard let node = t else {
                return ""
            }
            
            var code = "\(node.val),\(traverse(t:node.left)),\(traverse(t:node.right))"
            if let count = dict[code] {
                if count == 1 {
                    result.append(node)
                }
                
                dict[code] = count + 1
            } else {
                dict[code] = 1
            }
            
            return code
        }
        
        traverse(t: root)
        return result
    }
    // 102. Binary Tree Level Order Traversal
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        var maxLevel = 0
        var helper = [Int: [Int]]()
        
        func traverseTree(tree:TreeNode?, cLevel:Int) {
            guard let node = tree else {
                return
            }
            
            if var nodes = helper[cLevel] {
                nodes.append(node.val)
                helper[cLevel] = nodes
            } else {
                helper[cLevel] = [node.val]
            }
            
            maxLevel = max(maxLevel, cLevel)
            
            traverseTree(tree:node.left, cLevel: cLevel + 1)
            traverseTree(tree:node.right, cLevel: cLevel + 1)
        }
        traverseTree(tree:root, cLevel:0)
        for i in 0...maxLevel {
            if let nodes = helper[i] {
                result.append(nodes)
            }
        }
        return result
    }
    
    //222. Count Complete Tree Nodes
    
    // This is a tricky one. We first calculate the depth of the left node and right node, if it is complete binary tree. calculate the node number. otherwise return 1 + left node number + right node number
    func countNodes(_ root: TreeNode?) -> Int {
        
        guard let rootNode = root else {
            return 0
        }
        
        let leftD = leftDepth(root:rootNode)
        let rightD = rightDepth(root:rootNode)
        
        if leftD == rightD {
            return Int(pow(Double(2),Double(leftD))) - 1
        } else {
            return 1 + countNodes(rootNode.left) + countNodes(rootNode.right)
        }
    }
    
    func rightDepth(root: TreeNode?) -> Int {
        var count = 0
        var rootNode = root
        while rootNode != nil {
            rootNode = rootNode?.right
            count += 1
        }
        return count
    }
    
    func leftDepth(root: TreeNode?) -> Int {
        var count = 0
        var rootNode = root
        while rootNode != nil {
            rootNode = rootNode?.left
            count += 1
        }
        return count
    }
    
    //543. Diameter of Binary Tree
    //For this question, we calculate the max depth of a tree as normal. The difference is that we use             ans = max(ans, maxL + maxR) to memorize the max length between the max depth of the node's left child and its right child.

    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        
        var ans = 0
        func maxDepth(node: TreeNode?) -> Int {
            guard let n = node else {
                return 0
            }
            
            let maxL = maxDepth(node:n.left)
            let maxR = maxDepth(node:n.right)
            
            
            ans = max(ans, maxL + maxR)
            return max(maxL,maxR) + 1
        }
        
        
        
        maxDepth(node:root)
        return ans
    }
    
    //199. Binary Tree Right Side View
    // The trick here is that with preorder traverse, the right node is always visited last. So that if you overwirte the value, it will be the right side view.
    func rightSideView(_ root: TreeNode?) -> [Int] {
        var memo = [Int: Int]()
        var maxLevel = 0
        
        
        func traverse(node:TreeNode?, cLevel: Int) {
            guard let n = node else {
                return
            }
            
            memo[cLevel] = n.val
            maxLevel = max(maxLevel, cLevel)
            traverse(node:n.left,cLevel:cLevel + 1)
            traverse(node:n.right,cLevel:cLevel + 1)
        }
        
        traverse(node:root, cLevel:0)
        
        var result = [Int]()
        
        for i in 0...maxLevel {
            if let val = memo[i] {
                result.append(val)
            }
        }
        
        return result
    }
    
    //113. Path Sum II
    // Note the sum is not neccessarily positive

    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        var result = [[Int]]()
        
        
        func traverse(root: TreeNode?, sum: Int, path: [Int]) {
            guard let node = root else {
                return
            }
            
            if node.left == nil && node.right == nil && sum == node.val {
                result.append(path + [node.val])
                return
            }
            
            traverse(root:node.left, sum: sum - node.val, path:path + [node.val])
            traverse(root:node.right, sum: sum - node.val, path:path + [node.val])
        }
        
        traverse(root: root, sum: sum, path: [Int]())
        return result
    }
    
    // 96. Unique Binary Search Trees
    // assume dp[n] is the number of unique BSTs that stores 1...n
    // dp[0] = 1 dp[1] = 1 dp[2] = 2 dp[3] = 5
    // take [1, 2, 3, 4] for example, if we take 1 as root, then we need to find the number of BSTs that
    // stores [2, 3, 4]. Apparrently the number is the same as [1, 2, 3] which is dp[3]. so the result is dp[0]*dp[3]
    // Samilarly. if we take 2 as root then result is dp[1] * dp[2]
    // dp[4] = dp[0] * dp[3] + dp[1] * dp[2] + dp[2] * dp[1] + dp[3] * dp[0] = 14
    // dp[n] = dp[0] * dp[n - 1] + ... + dp[n-1] * dp[1]
    func numTrees(_ n: Int) -> Int {
       
        
        var dp = [Int:Int]()
        
        dp[0] = 1
        dp[1] = 1
        
        for i in 1...n {
            var temp = 0
            for j in 1...i{
                temp += dp[i - j]! * dp[j - 1]!
            }
            dp[i] = temp
        }
        return dp[n]!
    }
    
    
    //230. Kth Smallest Element in a BST
    // The trick is that in BST if you in order traverse then the value will be in sorted descend order.
    // So we build the array then then nth smallest number is memo[n - 1]
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var memo = [Int]()
        func traverse(root: TreeNode?) {
            guard let n = root else {
                return
            }
            traverse(root:n.left)
            memo.append(n.val)
            traverse(root:n.right)
        }
        
        traverse(root:root)
        return memo[k - 1]
    }
    
    //538. Convert BST to Greater Tree
    // Similar to 230. The trick here is that if you taverse a BST right - self - left, you will get the ascend
    // order of the value. then use a temp variable to track the value that is currently large, add it to next visited node.
    func convertBST(_ root: TreeNode?) -> TreeNode? {
        var temp = 0
        
        func traverse(root: TreeNode?) {
            guard let n = root else {
                return
            }
            
            traverse(root: n.right)
            n.val = n.val + temp
            temp = n.val
            traverse(root: n.left)
        }
        
        traverse(root: root)
        
        return root
    }
    
    //617. Merge Two Binary Trees
    func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        func buildNode(t1: TreeNode?, t2: TreeNode?) -> TreeNode? {
            if t1 == nil && t2 == nil {
                return nil
            } else if t1 == nil {
                return TreeNode(t2!.val)
            } else if t2 == nil {
                return TreeNode(t1!.val)
            } else {
                return TreeNode(t1!.val + t2!.val)
            }
        }
        
        
        guard let node = buildNode(t1:t1, t2:t2) else {
            return nil
        }
        
        node.left = mergeTrees(t1?.left, t2?.left)
        node.right = mergeTrees(t1?.right, t2?.right)
        
        return node
        
    }
    
    //129. Sum Root to Leaf Numbers
    func sumNumbers(_ root: TreeNode?) -> Int {
        var result = 0
        
        func traverse(root: TreeNode?, cValue: Int) {
            guard let n = root else {
                return
            }
            
            if n.left == nil && n.right == nil {
                result += cValue * 10 + n.val
                return
            }
            
            traverse(root:n.left, cValue: cValue * 10 + n.val)
            traverse(root:n.right, cValue: cValue * 10 + n.val)
        }
        
        traverse(root:root, cValue:0)
        return result
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


//Here is the solustion with memo. complexity Wn
func knapsack(W:Int,ws:[Int],vs:[Int]) -> Int {
    var memo = Array(repeating: Array(repeating:-1, count:ws.count), count: W + 1)
    
    func knapsackDP(weightLimit:Int, weights:[Int], values:[Int], index: Int) -> Int {
        
        if weightLimit <= 0 || index == 0 {
            return 0
        } else if memo[weightLimit][index] != -1 {
            print("return mmo")
            return memo[weightLimit][index]
        } else {
            memo[weightLimit][index] = max(knapsackDP(weightLimit: weightLimit,
                                                      weights: weights,
                                                      values: values,
                                                      index: index - 1), knapsackDP(weightLimit: weightLimit  - weights[index],
                                                                                    weights: weights,
                                                                                    values: values,
                                                                                    index: index - 1) + values[index])
            return memo[weightLimit][index]
        }
        
        
        
    }
    
    return knapsackDP(weightLimit: W, weights: ws, values: vs, index: ws.count - 1)
    
    
}

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




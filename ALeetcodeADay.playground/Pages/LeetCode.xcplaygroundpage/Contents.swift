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
        var queue = [String]()
        var sArray = s.map{ String($0) }
        
        for i in 0..<sArray.count {
            if sArray[i] == "[" ||  sArray[i] == "(" || sArray[i] == "{" {
                queue.append(sArray[i])
            } else if sArray[i] == "]" {
                if queue.count == 0 {
                    return false
                } else if queue.removeLast() != "[" {
                    return false
                }
            } else if sArray[i] == ")" {
                if queue.count == 0 {
                    return false
                } else if queue.removeLast() != "(" {
                    return false
                }
            } else if sArray[i] == "}" {
                if queue.count == 0 {
                    return false
                } else if queue.removeLast() != "{" {
                    return false
                }
            }
        }
        
        return queue.count == 0
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
    
    /*
     Sliding window problem
     */
    //3. Longest Substring Without Repeating Characters
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.count > 0 else {
            return 0
        }
        
        var j = 0
        var i = 0
        var dict = [String: Bool]()
        var result = Int.min
        var s = s.map{ String($0) }
        
        while j < s.count {
            if dict[s[j]] == true {
                while dict[s[j]] == true {
                    dict[s[i]] = nil
                    i += 1
                }
            }
            dict[s[j]] = true
            result = max(result, j - i + 1)
            j += 1
        }
        
        return result
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
    
    
    func combinationSumV1(_ candidates: [Int], _ target: Int) -> [[Int]] {
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
    
    
    func subsetsV2(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        
        func getSet(set:[Int], list:[Int]) {
            if list.count == 0 {
                return
            }
            var list = list
            while list.count != 0 {
                let newSet = set + [list.removeFirst()]
                result.append(newSet)
                getSet(set:newSet, list:list)
            }
        }
        
        getSet(set:[Int](), list:nums)
        result.append([])
        return result
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
    
    
    //198 House Robber bottom up iteral
    /*
     The robber has two options: rob hous i or not.
     If the robber rob house i then, he cannot rob house i - 1, but he can get max result from i - 2. If robber does not rob house i, then he can get the max value until house i - 1
     Time: O(n)
     Space: O(n)
     */
    
    func robIter(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        
        guard nums.count > 1 else {
            return nums[0]
        }
        
        var dp = [Int](repeating:0, count: nums.count + 1)
        dp[0] = 0
        dp[1] = nums[0]
        
        for i in 2...nums.count {
            dp[i] = max(dp[i - 2] + nums[i - 1], dp[i - 1])
        }
        
        return dp[nums.count]
    }
    
    //213. House Robber II
    /* We can not rob house n and house 0 at the same time. so we can either rob house 1 - house n or rob house 0 to house n - 1
     */
    func rob(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        
        guard nums.count > 1 else {
            return nums[0]
        }
        
        guard nums.count > 2 else {
            return max(nums[0], nums[1])
        }
        
        var dp = [Int](repeating:0, count: nums.count)
        
        var nums1 = nums
        var nums2 = nums
        nums1.removeFirst()
        nums2.removeLast()
        
        //we rob house 0 to house n - 1
        dp[0] = 0
        dp[1] = nums1[0]
        for i in 2...nums1.count {
            dp[i] = max(dp[i - 1], dp[i - 2] + nums1[i - 1])
        }
        let p1 = dp[nums1.count]
        
        //we rob house 1 to house n
        dp[0] = 0
        dp[1] = nums2[0]
        for i in 2...nums2.count {
            dp[i] = max(dp[i - 1], dp[i - 2] + nums2[i - 1])
        }
        let p2 = dp[nums2.count]
        
        
        return max(p1,p2)
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
    //692. Top K Frequent Words
    // Pay attention to how to use sort to sort the set.
    // Big O: N + NlogN = NlogN
    func topKFrequent(_ words: [String], _ k: Int) -> [String] {
        var dict = [String: Int]()
        
        for word in words {
            dict[word] = dict[word, default: 0] + 1
        }
        
        var wordsSet = Array(Set(words))
        
        wordsSet.sort{
            if dict[$0]! > dict[$1]! {
                return true
            } else if dict[$0]! == dict[$1]! {
                return $0 < $1
            } else {
                return false
            }
        }
        
        return Array(wordsSet[0...k - 1])
        
    }
    
    // 637. Average of Levels in Binary Tree
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        var dict = [Int: (Int, Int)]()
        var maxLevel = 0
        var result = [Double]()
        
        func traverse(root: TreeNode?, cLevel: Int) {
            guard let n = root else {
                return
            }
            
            if let temp = dict[cLevel] {
                dict[cLevel] = (temp.0 + n.val, temp.1 + 1)
            } else {
                dict[cLevel] = (n.val, 1)
            }
            
            maxLevel = max(maxLevel,cLevel)
            
            traverse(root:n.left, cLevel:cLevel + 1)
            traverse(root:n.right, cLevel:cLevel + 1)
        }
        
        traverse(root: root, cLevel: 0)
        
        for i in 0...maxLevel {
            result.append(Double(dict[i]!.0)/Double(dict[i]!.1))
        }
        
        return result
        
    }
    
    //101. Symmetric Tree
    //TODO: Figure this out
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        
        func isMirror(m: TreeNode?, n: TreeNode?) -> Bool {
            if m == nil && n == nil {
                return true
            } else if m == nil || n == nil {
                return false
            } else {
                return m!.val == n!.val && isMirror(m:m!.left, n:n!.right) && isMirror(m:m!.right, n:n!.left)
            }
        }
        
        return isMirror(m:root, n:root)
        
    }
    
    //328. Odd Even Linked List
    // The node convention is very complex. Note "even != nil && even!.next != nil"

    func oddEvenList(_ head: ListNode?) -> ListNode? {
        guard let headNode = head else {
            return nil
        }
        
        var odd: ListNode? = headNode
        var even: ListNode? = headNode.next
        var evenHead: ListNode? = headNode.next
        
        while even != nil && even!.next != nil {
            odd!.next = even!.next
            odd = odd!.next
            even!.next = odd!.next
            even = even!.next
        }
        
        odd!.next = evenHead
        
        return headNode
        
    }
    
    //633. Sum of Square Numbers
    // Note if you are using double loop it will time out
    
    func judgeSquareSum(_ c: Int) -> Bool {
        var i = 0
        
        while i * i <= c {
            let j = Int(sqrt(Double(c - i * i)))
            if j * j + i * i == c {
                return true
            }
            i += 1
        }
        return false
    }
    
    //643. Maximum Average Subarray I
    func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        var head = 0
        var end = k - 1
        var currentSum: Double = 0
        
        let doubleNums = nums.map({ Double($0) })
        
        for i in head...end {
            currentSum += doubleNums[i]
        }
        
        var result = Double(currentSum)/Double(k)
        
        while end + 1 < doubleNums.count {
            currentSum = currentSum - doubleNums[head] + doubleNums[end + 1]
            result = max(currentSum/Double(k), result)
            head += 1
            end += 1
        }
        
        return result
    }
    
    // 554. Brick Wall
    // hash map is the key!
    func leastBricks(_ wall: [[Int]]) -> Int {
        //Note: This should be accepted because this is exactly the same solution as the the answer. However due to the nature of swift (AKA slow). The excution time out. : (
        var dict = [Int:Int]()
        var total = wall[0].reduce(0,+)
        var result = 0
        
        for line in wall {
            var numReached = 0
            for brick in line {
                numReached = numReached + brick
                if let reached = dict[numReached] {
                    dict[numReached] = reached + 1
                } else {
                    dict[numReached] = 1
                }
            }
        }
        
        for i in 1..<total {
            if let brickPassed = dict[i] {
                result = max(result,brickPassed)
            }
        }
        
        return wall.count - result
        
    }
    
    //462. Minimum Moves to Equal Array Elements II
    func minMoves2(_ nums: [Int]) -> Int {
        /*
         We need to sort the array first, then
         Take a = [1, 3, 4, 5, 6, 8] for example, var i = 0, var j = a.count - 1.
         Assume the num we are looking for is a[x]. Then the steps that need to
         tranfer a[i] and a[j] to a[x] is a[x] - a[i] + a[j] - a[x] = a[j] - a[i].
         then we narray i and j to get the total steps
         */
        
        var i = 0
        var j = nums.count - 1
        var result = 0
        
        let sortedNums = nums.sorted(by:{ $0 < $1 })
        
        while i < j {
            result += sortedNums[j] - sortedNums[i]
            i += 1
            j -= 1
        }
        
        return result
    }
    
    //701. Insert into a Binary Search Tree
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        func insertNode(node:TreeNode?, val:Int) {
            guard let n = node else {
                return
            }
            
            if val < n.val {
                if n.left == nil {
                    n.left = TreeNode(val)
                    return
                } else {
                    return insertNode(node:n.left!, val: val)
                }
            } else if val > n.val {
                if n.right == nil {
                    n.right = TreeNode(val)
                    return
                } else {
                    return insertNode(node:n.right!, val: val)
                }
            }
        }
        insertNode(node:root, val: val)
        return root
    }
    
    //83. Remove Duplicates from Sorted List
    //Must draw picture for linked list problems!!
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard let n = head else {
            return head
        }
        
        var cNode: ListNode? = n
        
        while cNode != nil {
            if let nNode = cNode!.next {
                if nNode.val == cNode!.val {
                    cNode!.next = nNode.next
                } else {
                    cNode = cNode!.next
                }
            } else {
                cNode = cNode!.next
            }
        }
        
        return n
    }
    
    //409. Longest Palindrome
    func longestPalindrome(_ s: String) -> Int {
        var memo = [Character: Bool]()
        var result = 0
        for char in s {
            if memo[char] == true {
                result += 2
                memo[char] = false
            } else {
                memo[char] = true
            }
        }
        
        for char in s {
            if memo[char] == true {
                result += 1
                break
            }
        }
        return result
    }
    
    //334. Increasing Triplet Subsequence
    func increasingTriplet(_ nums: [Int]) -> Bool {
        var c1 = Int.max
        var c2 = Int.max
        
        for num in nums {
            if num <= c1 {
                c1 = num // The smallest candidate
            } else if num <= c2 {
                c2 = num // The second smallest candidate
            } else {
                return true // If any number is larger than 2 numbers, then it is true
            }
        }
        
        return false
    }
    
    //486. Predict the Winner
    func PredictTheWinner(_ nums: [Int]) -> Bool {
        guard nums.count > 1 else {
            return true
        }
        
        let winScore = nums.reduce(0,+)
        
        var dp = Array(repeating:Array(repeating:0,count:nums.count), count:nums.count)
        // dp[i][j] The max score A can get between index i and index j
        // Note that dp[i][j] can also represent the max core B can get, as  A and B will both choose the same method
        // e.g. they are equally smart
        // dp[i][i] = nums[i]
        // if i is taken, then dp[i][j] = sum(i + 1, j) - d[i + 1][j] + num[i] = sum(i, j) - d[i + 1][j]
        // if j is taken, then dp[i][j] = sum(i, j - 1) - d[i][j - 1] + num[j] = sum(i, j) - d[i][j - 1]
        // as a result dp[i][j] = max(sum(i, j) - d[i + 1][j],  sum(i, j) - d[i][j - 1])
        // Draw a block diagram then we can see, the best way to fill the dp is
        // i -> nums.count - 1...0
        // j -> i...0
        
        for j in 0..<nums.count {
            var sum = 0
            for i in (0...j).reversed() {
                sum += nums[i]
                if i == j {
                    // This is a good example to avoid pre calculate the values and at the same time save
                    // The headache to figureout the boundarys
                    dp[i][j] = nums[j]
                } else {
                    dp[i][j] = max(sum - dp[i + 1][j],  sum - dp[i][j - 1])
                }
            }
        }
        
        return dp[0][nums.count - 1] * 2 >= winScore
    }
    
    //438. Find All Anagrams in a String
    
    //Use sliding window
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        guard s.count > 0 && p.count > 0 && p.count < s.count else {
            return [Int]()
        }
        
        let sArray = s.map{ String($0) }
        let pArray = p.map{ String($0) }
        var memo = [String: Int]()
        var result = [Int]()
        var begin = 0
        var end = 0
        
        var count = pArray.count
        
        //Record all chars needed to find
        for c in pArray {
            memo[c] = memo[c, default: 0] + 1
        }
        
        while end < s.count {
            //If c is needed and needed at lest 1, count - 1
            if let c = memo[sArray[end]]
            {
                memo[sArray[end]] = c - 1
                if c - 1 >= 0 {
                    count -= 1
                }
            }
            
            if count == 0 {
                result.append(begin)
            }
            
            // while end reach the window limit, we drop the begin. If begin contains
            // char needed, add it back to needed list
            if end - begin + 1 == pArray.count {
                if let c = memo[sArray[begin]]
                {
                    memo[sArray[begin]] = c + 1
                    if c + 1 > 0 {
                        count += 1
                    }
                }
                begin += 1
            }
            
            end += 1
        }
        return result
    }
    //796. Rotate String
    func rotateString(_ A: String, _ B: String) -> Bool {
        
        guard A.count == B.count else {
            return false
        }
        
        guard A.count > 0 else {
            return true
        }
        
        var temp = A.map{ String($0) }
        
        for i in 0...A.count {
            temp = Array(temp.dropFirst() + [temp.first!])
            var newString = temp.joined(separator:"")
            if newString == B {
                return true
            }
        }
        
        return false
        
        
    }
    
    //876. Middle of the Linked List
    func middleNode(_ head: ListNode?) -> ListNode? {
        
        guard let n = head else {
            return nil
        }
        
        var p1: ListNode? = n
        var p2: ListNode? = n
        
        while p2?.next != nil {
            p1 = p1?.next
            p2 = p2?.next?.next
        }
        return p1
    }
    
    //137. Single Number II
    func singleNumber(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        
        var temp = [Int: Int]()
        
        for num in nums {
            temp[num] = temp[num, default: 0] + 1
        }
        
        for key in temp.keys {
            if temp[key]! == 1 {
                return key
            }
        }
        
        return 0
    }
    //168. Excel Sheet Column Title
    func convertToTitle(_ n: Int) -> String {
        guard n > 0 else {
            return ""
        }
        
        let temp = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map{ String($0) }
        
        var result = [String]()
        
        var num = n
        
        while num > 0 {
            //Note the num - 1 instead of num
            result.append(temp[(num - 1)%26])
            num = (num - 1)/26
        }
        
        return result.reversed().joined(separator:"")
    }
    
    
    //713. Subarray Product Less Than K
    //Another sliding window problem
    func numSubarrayProductLessThanK(_ nums: [Int], _ k: Int) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        
        var result = 0
        
        var begin = 0
        var end = 0
        var prod = 1
        
        while end < nums.count {
            prod *= nums[end]
            //Note begin could be 1 larger than end. then end - beign = -1, any number that larger than k will be disqualified
            while begin <= end && prod >= k {
                prod = prod/nums[begin]
                begin += 1
            }
            
            result += end - begin + 1
            end += 1
        }
        
        return result
    }
    
    //784. Letter Case Permutation

    func letterCasePermutation(_ S: String) -> [String] {
        var result = [""]
        var number = "0123456789"
        
        var sArray = S.map({ String($0) })
        
        for char in sArray {
            if number.contains(char) {
                for i in 0..<result.count {
                    result[i] += char
                }
            } else {
                var s1 = result
                var s2 = result
                
                for i in 0..<result.count {
                    s1[i] += char.lowercased()
                }
                
                for i in 0..<result.count {
                    s2[i] += char.uppercased()
                }
                result = s1 + s2
            }
        }
        
        return result
        
    }
    
    //766. Toeplitz Matrix

    func isToeplitzMatrix(_ matrix: [[Int]]) -> Bool {
        guard matrix.count > 0 else {
            return true
            
            
        }
        
        for i in 0..<matrix[0].count - 1 {
            for j in 0..<matrix.count - 1 {
                if matrix[j][i] != matrix[j + 1][i + 1] {
                    return false
                }
            }
        }
        
        return true
        
    }
    
    //55. Jump Game
    func canJump(_ nums: [Int]) -> Bool {
        guard nums.count > 1 else {
            return true
        }
        
        var cStep = Int.min + 1
        
        for i in 0..<nums.count - 1 {
            cStep -= 1
            cStep = max(nums[i], cStep)
            if cStep <= 0 {
                return false
            }
        }
        
        return true
    }
    //153. Find Minimum in Rotated Sorted Array

    func findMin(_ nums: [Int]) -> Int {
        
        var begin = 0
        var end = nums.count - 1
        
        while begin < end {
            if nums[begin] < nums[end] {
                return nums[begin]
            } else {
                var mid = (end + begin)/2
                if nums[mid] >= nums[begin] {
                    begin = mid + 1
                } else {
                    //notice that mid should not be end - 1
                    end = mid
                }
            }
        }
        
        return nums[begin]
        
    }
    
    //383. Ransom Note

    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var memo = [Character: Int]()
        for char in magazine {
            memo[char] = memo[char, default:0] + 1
        }
        for char in ransomNote {
            guard
                let count = memo[char],
                count > 0
                else {
                    return false
            }
            memo[char] = count - 1
        }
        return true
    }
    
    //167. Two Sum II - Input array is sorted
    // AC answer O(nlogn)
    func twoSumBad(_ numbers: [Int], _ target: Int) -> [Int] {
        func binarySearch(nums:[Int], t:Int) -> Int {
            var begin = 0
            var end = nums.count - 1
            
            while begin <= end {
                var mid = (end + begin)/2
                if t > nums[mid] {
                    begin = mid + 1
                } else if t < nums[mid] {
                    end = mid - 1
                } else {
                    return mid
                }
            }
            
            return -1
            
        }
        
        
        for i in 0..<numbers.count {
            var temp = numbers
            temp.remove(at:i)
            
            var index = binarySearch(nums:temp, t:target - numbers[i])
            
            if index >= 0 {
                if index >= i {
                    index += 1
                }
                
                return [i + 1, index + 1]
            }
        }
        
        return [Int]()
        
    }
    
    //Better answer O(n)
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        guard numbers.count > 0 else {
            return [Int]()
        }
        var begin = 0
        var end = numbers.count - 1
        
        while begin < end {
            if numbers[begin] + numbers[end] > target {
                end -= 1
            } else if numbers[begin] + numbers[end] < target {
                begin += 1
            } else {
                return [begin + 1, end + 1]
            }
        }
        
        return [Int]()
    }
    
    //200. Number of Islands

    func numIslands(_ grid: [[Character]]) -> Int {
        guard grid.count > 0 else {
            return 0
        }
        
        var visited = Array(repeating:Array(repeating:false, count:grid[0].count), count:grid.count)
        var result = 0
        
        
        func visit(i:Int, j:Int) {
            if i >= grid.count || j >= grid[0].count || i < 0 || j < 0 || visited[i][j] == true || grid[i][j] == "0" {
                return
            } else {
                visited[i][j] = true
                visit(i:i - 1, j:j)
                visit(i:i + 1, j: j)
                visit(i:i, j:j + 1)
                visit(i:i, j:j - 1)
            }
        }
        
        
        for i in 0..<grid.count {
            for j in 0..<grid[0].count {
                if grid[i][j] == "1" && visited[i][j] == false {
                    result += 1
                    visit(i:i, j:j)
                }
            }
        }
        
        
        return result
    }
    
    //13. Roman to Integer

    func romanToInt(_ s: String) -> Int {
        var sArray = s.map{String($0)}
        
        var value = [String: Int]()
        
        var result = 0
        value["I"] = 1
        value["V"] = 5
        value["X"] = 10
        value["L"] = 50
        value["C"] = 100
        value["D"] = 500
        value["M"] = 1000
        
        for i in 0..<sArray.count {
            result += value[sArray[i]]!
            
            if (sArray[i] == "V" || sArray[i] == "X") && i - 1 >= 0 && sArray[i - 1] == "I" {
                result -= 2
            } else if (sArray[i] == "L" || sArray[i] == "C") && i - 1 >= 0 && sArray[i - 1] == "X" {
                result -= 20
            } else if (sArray[i] == "D" || sArray[i] == "M") && i - 1 >= 0 && sArray[i - 1] == "C" {
                result -= 200
            }
        }
        
        return result
    }
    
   // 15. 3Sum
    /*
     We want traverse the array, for each element, we look for uniqu num[j] + num[k] = -num[i]
     The tricky part is we use two pointer to go through the candicate for num[i], ignore the duplicate nums, then append them to the result
 */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return []
        }
        
        let sortedNum = nums.sorted(by: {$0<$1})
        
        var result = [[Int]]()
        
        
        for i in 0..<sortedNum.count - 2 {
            if i == 0 || (sortedNum[i] != sortedNum[i - 1]) {
                var low = i + 1
                var high = sortedNum.count - 1
                var sum = 0 - sortedNum[i]
                
                while low < high {
                    if sortedNum[low] + sortedNum[high] == sum {
                        result.append([sortedNum[i], sortedNum[low], sortedNum[high]])
                        while low < high && sortedNum[low] == sortedNum[low + 1] {
                            low += 1
                        }
                        
                        while low < high && sortedNum[high] == sortedNum[high - 1] {
                            high -= 1
                        }
                        
                        low += 1
                        high -= 1
                    } else if sortedNum[low] + sortedNum[high] < sum {
                        low += 1
                    } else {
                        high -= 1
                    }
                }
                
                
            }
        }
        
        return result
        
    }
    
    //56. Merge Intervals
    // The idea is sort the interval by its start time, to avoid the scenario that a block of time slot is wasted.
    // for each interval, we check current meeting room schedule, if there is space, then put it in and update the meeting room schedule, otherwise create another meeting room
    func merge(_ intervals: [Interval]) -> [Interval] {
        guard intervals.count > 0 else {
            return [Interval]()
        }
        
        var sortedInter = intervals
        sortedInter.sort(by:({ $0.start < $1.start }))
        
        var start = sortedInter[0].start
        var end = sortedInter[0].end
        var i = 1
        var result = [Interval]()
        
        while i < sortedInter.count {
            if  end < sortedInter[i].start {
                result.append(Interval(start, end))
                start = sortedInter[i].start
                end = sortedInter[i].end
            } else if end <= sortedInter[i].end && end >= sortedInter[i].start {
                end = sortedInter[i].end
            }
            
            i += 1
        }
        
        result.append(Interval(start, end))
        
        return result
        
    }
   // 139. Word Break
    //Dp solution. we assume dp[i] is if a word ends at index i. then dp is true if dict contains s[i...j] and dp[i] == true
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        var dp = Array(repeating:false, count:s.count)
        
        var sArray = s.map{ String($0) }
        
        for i in 0..<s.count {
            for j in 0...i {
                var subString = sArray[j...i].joined(separator:"")
                if wordDict.contains(subString) && ( j == 0 || dp[j - 1] == true ) {
                    dp[i] = true
                    break
                }
            }
        }
        
        return dp[s.count - 1]
        
    }
    
    //26. Remove Duplicates from Sorted Array
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 1 else {
            return nums.count
        }
        
        var i = 0
        
        while i < nums.count - 1{
            if nums[i] == nums[i + 1] {
                nums.remove(at: i)
            } else {
                i += 1
            }
        }
        
        return nums.count
    }
    
    
    //33. Search in Rotated Sorted Array
    //[4, 5, 6, 7, 0, 1, 2]
    /*
     first we get a middle number, then if the middle num matchs nums[l] < num[m] then
     the nums[l...m] is a sorted array. If the target > nums[l] and target < nums[m] then the target is inside
     the sub arrya. Do a binary search and you will find the value other wise we search the nums in the other sub string, until we find the target.
     
     The tricky part is for the scenario [3, 1] which is indeed an unsorted array.
     */
    func search(_ nums: [Int], _ target: Int) -> Int {
        func binarySearch(nums:[Int], target: Int, indexL: Int, indexH: Int) -> Int {
            var low = indexL
            var high = indexH
            
            while low <= high {
                let middle = (high + low)/2
                if nums[middle] > target {
                    high = middle - 1
                } else if nums[middle] < target {
                    low = middle + 1
                } else {
                    return (high + low)/2
                }
            }
            return -1
        }
        
        func searchNum(nums:[Int], target:Int, indexLow:Int, indexHigh:Int) -> Int {
            var low = indexLow
            var high = indexHigh
            
            let middle = (high + low)/2
            
            if indexLow == indexHigh {
                return nums[indexLow] == target ? indexLow : -1
            }  else if nums[low] <= nums[middle] {
                if target >= nums[low] && target <= nums[middle] {
                    return binarySearch(nums:nums, target: target, indexL: low, indexH: middle)
                }  else {
                    return searchNum(nums:nums, target:target, indexLow:middle + 1, indexHigh: high)
                }
            } else if nums[middle] <= nums[high] {
                if target >= nums[middle] && target <= nums[high] {
                    return binarySearch(nums:nums, target: target, indexL:middle, indexH: high)
                } else {
                    return searchNum(nums: nums, target:target, indexLow:low, indexHigh: middle - 1)
                }
            }
            
            return -1
        }
        
        guard nums.count > 0 else {
            return -1
        }
        
        return searchNum(nums:nums, target: target, indexLow:0, indexHigh: nums.count - 1)
    }
    
    //23. Merge k Sorted Lists

    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var lists = lists.flatMap({ $0 })
        var result = ListNode(-1)
        var rPointer: ListNode? = result
        
        func mergeLists(cLists: [ListNode]) {
            guard cLists.count > 0 else {
                return
            }
            
            var cLists = cLists
            
            var cMin = ListNode(Int.max)
            var index = -1
            
            for i in 0..<cLists.count {
                if cLists[i].val < cMin.val {
                    cMin = cLists[i]
                    index = i
                }
            }
            
            rPointer?.next = ListNode(cMin.val)
            rPointer = rPointer?.next
            
            if cLists[index].next == nil {
                cLists.remove(at: index)
            } else {
                cLists[index] = cLists[index].next!
            }
            mergeLists(cLists:cLists)
        }
        
        mergeLists(cLists: lists)
        
        return result.next
        
    }
    
    //17. Letter Combinations of a Phone Number
    // The loop is tricky
    func letterCombinations(_ digits: String) -> [String] {
        var memo = [Character: [Character]]()
        
        memo["2"] = ["a", "b", "c"]
        memo["3"] = ["d", "e", "f"]
        memo["4"] = ["g", "h", "i"]
        memo["5"] = ["j", "k", "l"]
        memo["6"] = ["m", "n", "o"]
        memo["7"] = ["p", "q", "r", "s"]
        memo["8"] = ["t", "u", "v"]
        memo["9"] = ["w", "x", "y", "z"]
        
        var result = [String]()
        
        for char in digits {
            if let nChars = memo[char] {
                if result.count == 0 {
                    result = nChars.map( {String($0)} )
                } else {
                    var temp = [String]()
                    for i in 0..<result.count {
                        for nChar in nChars {
                            temp.append(result[i] + String(nChar))
                        }
                    }
                    result = temp
                }
            }
        }
        return result
    }
    //127. Word Ladder
    //BFS

    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        var set = Set(wordList)
        var az = "abcdefghijklmnopqrstuvwxyz"
        var cList = Array(set)
        
        guard cList.count > 0 else {
            return 0
        }
        
        func helper(beginWord: String, endWord: String, wordList: [String] ) -> Int {
            var queue = [String]()
            if !wordList.contains(endWord) {
                return 0
            }
            var wordList = wordList
            queue.append(beginWord)
            var path = 0
            while queue.count > 0 {
                let count = queue.count
                for i in 0..<count {
                    var cur = queue.removeFirst()
                    if cur == endWord {
                        return path + 1
                    }
                    
                    for i in 0..<cur.count {
                        var arrayC = Array(cur)
                        for char in az {
                            arrayC[i] = char
                            let check = String(arrayC)
                            if(wordList.contains(check) && check != cur) {
                                queue.append(check)
                                wordList = wordList.filter({ $0 != check })
                            }
                        }
                    }
                }
                path += 1
            }
            
            return 0
        }
        
        return helper(beginWord:beginWord, endWord: endWord, wordList: wordList)
        
    }
    
    // 67. Add Binary
    // The trick is do the add from the lower digit
    func addBinary(_ a: String, _ b: String) -> String {
        var carry = 0
        var i = a.count - 1
        var j = b.count - 1
        var result = ""
        
        var aArray = a.map({ String($0) })
        var bArray = b.map({ String($0) })
        
        
        while i >= 0 || j >= 0 {
            var sum = carry
            if i >= 0 {
                sum += Int(aArray[i])!
                i -= 1
            }
            
            if j >= 0 {
                sum += Int(bArray[j])!
                j -= 1
            }
            
            var cValue = sum % 2
            result = String(cValue) + result
            carry = sum / 2
        }
        
        if carry > 0 {
            result = "1" + result
        }
        
        return result
        
    }
    
    //301 Remove Invalid Parentheses
    func removeInvalidParentheses(_ s: String) -> [String] {
        func isValidP(s: String) -> Bool {
            var count = 0
            for char in s {
                if char == "(" {
                    count += 1
                } else if char == ")" {
                    count -= 1
                }
                if count < 0 {
                    return false
                }
            }
            return count == 0
        }
        
        var queue = [String]()
        var visited = [String: Bool]()
        var result = [String]()
        queue.append(s)
        
        // We use found to determin if the valid answer has been found in current level. If it is true, stop searching further
        var found = false;
        
        while queue.count > 0 {
            let cur = queue.removeFirst()
            if isValidP(s: cur) && visited[cur] == nil {
                result.append(cur)
                found = true
                visited[cur] = true
            }
            
            if found {
                continue
            }
            
            for i in 0..<cur.count {
                let index = cur.index(cur.startIndex, offsetBy:i)
                var newString = cur
                if newString[index] == "(" || newString[index] == ")" {
                    newString.remove(at: index)
                    if visited[newString] == nil {
                        queue.append(newString)
                        visited[cur] = true
                    }
                }
            }
            
            
        }
        
        return result
    }
    
    // 350. Intersection of Two Arrays II
    // O(max(m,n) * max(logm, logn))
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        guard nums1.count > 0 && nums2.count > 0 else {
            return [Int]()
        }
        
        var sortedN1 = nums1.sorted()
        var sortedN2 = nums2.sorted()
        
        var i = 0
        var j = 0
        
        var result = [Int]()
        
        while i < sortedN1.count && j < sortedN2.count {
            if sortedN1[i] < sortedN2[j] {
                i += 1
            } else if sortedN1[i] > sortedN2[j] {
                j += 1
            } else {
                result.append(sortedN1[i])
                i += 1
                j += 1
            }
        }
        
        return result
    }
    
    // 350. Intersection of Two Arrays II (hash table)
    // O(m + n)
    func intersect2(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        guard nums1.count > 0 && nums2.count > 0 else {
            return [Int]()
        }
        
        var result = [Int]()
        var memo = [Int:Int]()
        
        for n in nums1 {
            memo[n] = memo[n, default:0] + 1
        }
        
        for m in nums2 {
            if let count = memo[m] {
                memo[m] = count - 1
                if count - 1 >= 0 {
                    result.append(m)
                }
            }
        }
        
        return result
    }
    
    //79. Word Search
    // Next time use index instead of droping word to make the algorithm faster
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        guard word.count > 0  else {
            return true
        }
        
        guard board.count > 0 else {
            return false
        }
        
        var visited = Array(repeating:Array(repeating:false,count: board[0].count), count: board.count)
        
        func findChar(_ indexI:Int, _ indexJ:Int, _ word: String) -> Bool {
            if word.count == 0 {
                return true
            }
            
            if indexI >= board.count || indexJ >= board[0].count || indexI < 0 || indexJ < 0 || visited[indexI][indexJ] {
                return false
            }
            
            let fIndex = word.index(word.startIndex, offsetBy:0)
            let fChar = word[fIndex]
            
            if fChar != board[indexI][indexJ] {
                return false
            }
            
            visited[indexI][indexJ] = true
            
            let nWord = String(word.dropFirst())
            if findChar(indexI + 1, indexJ, nWord) ||
                findChar(indexI - 1, indexJ, nWord) ||
                findChar(indexI, indexJ + 1, nWord) ||
                findChar(indexI, indexJ - 1, nWord) {
                return true
            }
            
            visited[indexI][indexJ] = false
            return false
            
        }
        
        var startPoints = [[Int]]()
        
        let startIndex = word.index(word.startIndex, offsetBy:0)
        let startChar = word[startIndex]
        
        for m in 0..<board.count{
            for n in 0..<board[m].count {
                if board[m][n] == startChar &&  findChar(m,
                                                         n,
                                                         word) {
                    return true
                }
            }
        }
        
        return false
    }
    
    //268. Missing Number

    func missingNumber(_ nums: [Int]) -> Int {
        //Calculate 1 + 2 + ... + n then mins sum(nums). The difference is the missing number
        return nums.count*(nums.count+1)/2 - nums.reduce(0, +)
    }
    
    //3. Longest Substring Without Repeating Characters
    //https://leetcode.com/problems/minimum-window-substring/discuss/26808/Here-is-a-10-line-template-that-can-solve-most-'substring'-problems
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var memo = [String: Int]()
        var result = 0
        var start = 0
        var end = 0
        
        var sArray = s.map{ String($0) }
        
        for char in sArray {
            memo[char] = 0
        }
        
        while end < s.count {
            if memo[sArray[end]]! == 0 {
                memo[sArray[end]] = 1
            } else if memo[sArray[end]]! == 1 {
                memo[sArray[end]]! += 1
                while memo[sArray[end]]! != 1 {
                    memo[sArray[start]]! -= 1
                    start += 1
                }
            }
            result = max(result, end - start + 1)
            end += 1
        }
        
        return result
        
    }
    //76. Minimum Window Substring
    //
    // This is similar to all the other sub string problem.
    //We have two pointer start and end, first we move end until a valid string is find.
    //Then move start until the string is invalid. Then move the end until the string is valid again.
    //The key here is that while you are moving the i, you keep check the result and current i...j sub string until we find an invalid sub string. remember checking does not cost anything
    
    func minWindow(_ s: String, _ t: String) -> String {
        var s = s.map{ String($0) }
        var t = t.map{ String($0) }
        
        guard s.count > 0 && t.count > 0 && t.count <= s.count else {
            return ""
        }
        
        var start = 0
        var end = 0
        
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
    
    //215. Kth Largest Element in an Array

    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var sortedNums = nums.sorted()
        return sortedNums[sortedNums.count - k]
    }
    
    
    //760. Find Anagram Mappings
    //Best example of using hash map
    func anagramMappings(_ A: [Int], _ B: [Int]) -> [Int] {
        var memo = [Int: Int]()
        var result = [Int]()
        for i in 0..<B.count {
            memo[B[i]] = i
        }
        
        for i in 0..<A.count {
            result.append(memo[A[i]]!)
        }
        
        return result
        
    }
    //700. Search in a Binary Search Tree

    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let node = root else {
            return nil
        }
        if node.val == val {
            return node
        } else if node.val > val {
            return searchBST(node.left, val)
        } else if node.val < val {
            return searchBST(node.right, val)
        }
        return nil
    }
    
   // 245. Shortest Word Distance III
    func shortestWordDistance(_ words: [String], _ word1: String, _ word2: String) -> Int {
        var index1 = [Int]()
        var index2 = [Int]()
        var result = Int.max
        
        for i in 0..<words.count {
            let word = words[i]
            if word == word1 {
                if word1 == word2 {
                    if let last = index1.last {
                        result = min(result, abs(last - i))
                    }
                } else if let last = index2.last {
                    result = min(result, abs(last - i))
                }
                index1.append(i)
            } else if word == word2 {
                if let last = index1.last {
                    result = min(result, abs(last - i))
                }
                index2.append(i)
            }
        }
        
        return result
    }
    
    // 437. Path Sum III

    func pathSum(_ root: TreeNode?, _ sum: Int) -> Int {
        guard let n = root else {
            return 0
        }
        
        func findPath(root: TreeNode?, target: Int) -> Int {
            guard let n = root else {
                return 0
            }
            
            
            return (n.val == target ? 1: 0) + findPath(root: n.left, target: target - n.val) + findPath(root:n.right, target:target - n.val)
        }

        return findPath(root: n, target: sum) + pathSum(n.left, sum) + pathSum(n.right, sum)
    }
    
    // 260. Single Number III
    func singleNumber(_ nums: [Int]) -> [Int] {
        var memo = [Int: Int]()
        var result = [Int]()
        
        for num in nums {
            memo[num] = memo[num, default:0] + 1
        }
        
        for key in memo.keys {
            if memo[key]! == 1 {
                result.append(key)
            }
        }
        
        return result
    }
    
    //392. Is Subsequence
    // O(nLog(n)) n is the length of t. Sorting
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        if s.count == 0 {
            return true
        } else if t.count == 0 {
            return false
        }
        
        var s = s.map({ String($0) })
        var t = t.map({ String($0) })
        
        var i = 0
        var j = 0
        
        while i < s.count && j < t.count {
            if s[i] == t[j] {
                i += 1
                j += 1
            } else {
                j += 1
            }
        }
        
        return i == s.count
    }
    
    
    //826. Most Profit Assigning Work
    func maxProfitAssignment(_ difficulty: [Int], _ profit: [Int], _ worker: [Int]) -> Int {
        typealias Job = (d:Int, p:Int)
        var jobs = [Job]()
        var result = 0
        
        for i in 0..<difficulty.count {
            jobs.append(Job(d:difficulty[i], p:profit[i]))
        }
        
        jobs.sort(by:{ $0.d < $1.d })
        let worker = worker.sorted(by:{ $0 < $1 })
        
        var i = 0
        
        //Note the max should be outside because the next worker is going to use it.
        var maxV = 0
        for w in worker {
            //Note the sequnce cannot be w >= jobs[i].d &&  i < jobs.count otherwise index out of range
            while  i < jobs.count && w >= jobs[i].d{
                maxV = max(maxV, jobs[i].p)
                i += 1
            }
            result += maxV
        }
        return result
    }
    
    // 872. Leaf-Similar Trees
    func leafSimilar(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        var seq = [Int]()
        
        func leafseq(node: TreeNode?) -> [Int]{
            guard let n = node else {
                return []
            }
            if n.left == nil && n.right == nil {
                return [n.val]
            }
            return leafseq(node: n.left) + leafseq(node: n.right)
        }
        
        var seq1 = leafseq(node:root1)
        var seq2 = leafseq(node:root2)
        
        if seq1.count != seq2.count {
            return false
        }
        
        for i in 0..<seq1.count {
            if seq1[i] != seq2[i] {
                return false
            }
        }
        return true
    }
    
    //896. Monotonic Array
    func isMonotonic(_ A: [Int]) -> Bool {
        guard A.count > 0 else {
            return false
        }
        
        if A.count == 1 {
            return true
        }
        
        var i = 0
        var j = 1
        
        var state = "unknown"
        
        while j < A.count {
            if A[i] > A[j]  {
                if state == "increasing" {
                    return false
                } else {
                    state = "decreasing"
                }
            } else if A[i] < A[j]  {
                if state == "decreasing" {
                    return false
                } else {
                    state = "increasing"
                }
            }
            i += 1
            j += 1
        }
        
        return true
    }
    
    //205. Isomorphic Strings
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }
        
        //Used to store that char that has been maped
        var memo = [Character:Character]()
        
        //Used to ensure that two char is not mapping to the same char
        var storedChar = [Character: Character]()
        
        for i in 0..<s.count {
            let index = s.index(s.startIndex, offsetBy: i)
            if let char = memo[s[index]] {
                if char != t[index] {
                    return false
                }
            } else {
                //This is to ensure the char has not been mapped before
                if storedChar[t[index]] != nil {
                    return false
                }
                memo[s[index]] = t[index]
                storedChar[t[index]] = s[index]
            }
        }
        
        return true
    }
    
    //366. Find Leaves of Binary Tree
    func findLeaves(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard root != nil else {
            return result
        }
        
        func removeLeaves(root: TreeNode?, parent: TreeNode, isLeftNode: Bool) -> [Int]{
            guard let n = root else {
                return []
            }
            
            if n.left == nil  && n.right == nil {
                if isLeftNode {
                    parent.left = nil
                } else {
                    parent.right = nil
                }
                return [n.val]
            }
            return removeLeaves(root: n.left, parent: n, isLeftNode: true) + removeLeaves(root: n.right, parent: n, isLeftNode: false)
        }
        
        //Use fakeNode to start
        var fakeNode = TreeNode(0)
        fakeNode.left = root
        
        while fakeNode.left != nil {
            result.append(removeLeaves(root:root, parent:fakeNode, isLeftNode: true))
        }
        return result
    }
    
    //84. Largest Rectangle in Histogram
    //Use dynamic programming
    func largestRectangleArea(_ heights: [Int]) -> Int {
        guard heights.count > 0 else {
            return 0
        }
        
        if heights.count == 1 {
            return heights[0]
        }
        
        var result = 0
        
        //DP[i][j] smallest element from index i to j
        //Then dp[i][j] = min(min(dp[i + 1][j], heights[i]), min(dp[i][j - 1], heights[j]))
        var dp = Array(repeating:Array(repeating:-1, count:heights.count), count: heights.count)
        
        
        for j in 0..<heights.count {
            for i in (0...j).reversed() {
                if i == j {
                    dp[i][j] = heights[i]
                } else {
                    dp[i][j] = min(min(dp[i + 1][j], heights[i]), min(dp[i][j - 1], heights[j]))
                }
                result = max(result, dp[i][j] * (j - i + 1))
            }
        }
        return result
    }
    
    //926. Flip String to Monotone Increasing
    //Calculate how many 1's one the left plus how many 0's one the right for each char. Then choose the one
    // with minimum zeros + ones
    func minFlipsMonoIncr(_ S: String) -> Int {
        typealias memo = (zeros:Int, ones:Int)
        
        var result = Array(repeating:memo(zeros:0,ones:0), count: S.count)
        
        guard S.count > 0 else {
            return 0
        }
        
        
        for i in 0..<S.count {
            let j = S.count - i - 1
            if i == 0 {
                result[i] = memo(zeros:0, ones:0)
                result[j] = memo(zeros:0, ones:0)
            } else {
                let previousI = result[i - 1]
                let pIndexI = S.index(S.startIndex, offsetBy:i - 1)
                if S[pIndexI] == "1" {
                    result[i] = memo(zeros:result[i].zeros, ones: previousI.ones + 1)
                } else {
                    result[i] = memo(zeros:result[i].zeros, ones: previousI.ones)
                }
                
                let previousJ = result[j + 1]
                let pIndexJ = S.index(S.startIndex, offsetBy:j + 1)
                
                if S[pIndexJ] == "0" {
                    result[j] = memo(zeros:previousJ.zeros + 1, ones: result[j].ones)
                } else {
                    result[j] = memo(zeros:previousJ.zeros, ones: result[j].ones)
                }
            }
        }
        
        var minNum = Int.max
        
        for m in result {
            minNum = min(minNum, m.zeros + m.ones)
            print("Current \(m.zeros) \(m.ones)")
        }
        
        return minNum
    }
    
    
    //680. Valid Palindrome II
    //Ensure that it is still valid palindrome after deleting one letter
    //O(n)
    func validPalindrome(_ s: String) -> Bool {
        
        
        var foundFlaw = false
        
        func helper(i:Int, j:Int, target: String) -> Bool {
            if i >= j {
                return true
            }
            
            let indexI = target.index(target.startIndex, offsetBy: i)
            let indexJ = target.index(target.startIndex, offsetBy: j)
            
            let charI = target[indexI]
            let charJ = target[indexJ]
            
            if charI == charJ {
                return helper(i:i + 1, j:j - 1, target: target)
            } else {
                if foundFlaw {
                    return false
                } else {
                    foundFlaw = true
                    return helper(i:i, j:j - 1, target: target) || helper(i:i + 1, j:j, target: target)
                }
            }
        }
        
        return helper(i:0, j:s.count - 1, target: s)
        
    }
    
    //687. Longest Univalue Path
    //We traverse the tree. Note at each tree we start a new traverse. If value == pre then it is part of the old travers plus that number. else return 0 to previous traverse
    func longestUnivaluePath(_ root: TreeNode?) -> Int {
        guard let n = root else {
            return 0
        }
        
        var result = Int.min
        
        func helper(root: TreeNode?, pre:Int) -> Int {
            guard let node = root else {
                return 0
            }
            let left = helper(root:node.left, pre: node.val)
            let right = helper(root:node.right, pre: node.val)
            result = max(result, left + right)
            if node.val == pre {
                return 1 + max(left, right)
            }
            return 0
        }
        
        
        helper(root: n, pre:n.val)
        return result
    }
    
    
    //567. Permutation in String

    /*
     Sliding window soluion. We use memo to track the chars in s1. Then use count to judge if
     All chars in s1 can be find in current window
     */
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        var s1 = s1.map({ String($0) })
        var s2 = s2.map({ String($0) })
        
        var memo = [String: Int]()
        var count = s1.count
        
        for char in s1 {
            memo[char] = memo[char, default:0] + 1
        }
        
        var i = 0
        var j = 0
        var pChar = ""
        
        while j < s2.count {
            if let pCount = memo[pChar] {
                memo[pChar] = pCount + 1
                //Note the count only increase if te previous char (the one slide out of the window)
                //is needed again.
                if pCount + 1 > 0 {
                    count += 1
                }
            }
            
            if let charCount = memo[s2[j]] {
                memo[s2[j]] = charCount - 1
                //Only increase the count when the need for this char is actually decreased (not duplicate)
                if charCount - 1 >= 0 {
                    count -= 1
                }
            }
            
            if count == 0 {
                return true
            }
            
            if j - i + 1 == s1.count {
                //Window size
                pChar = s2[i]
                i += 1
                j += 1
            } else {
                j += 1
            }
        }
        
        return false
        
    }
    
    // 783. Minimum Distance Between BST Nodes
    // MUST remember that mini difference for a binary search tree can
    // always be found via in-order-traverse (left- self - right).
    func minDiffInBST(_ root: TreeNode?) -> Int {
        var result = Int.max
        var pre: Int? = nil
        
        guard let node = root else {
            return 0
        }
        
        
        func traverse(cRoot:TreeNode?) {
            guard let n = cRoot else {
                return
            }
            
            traverse(cRoot:n.left)
            
            if let pVal = pre {
                result = min(abs(pVal - n.val), result )
            }
            
            pre = n.val
            traverse(cRoot:n.right)
        }
        
        traverse(cRoot:root)
        
        return result
    }
    
    //560. Subarray Sum Equals K
    // https://leetcode.com/problems/subarray-sum-equals-k/discuss/134689/Three-Approaches-With-Explanation
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var memo = [Int: Int]()
        var sum = 0
        var result = 0
        
        guard nums.count > 0 else {
            return 0
        }
        
        // This is important. In case the num is eaqual to the value
        memo[0] = 1
        
        for i in 0..<nums.count {
            sum += nums[i]
            if let count = memo[sum - k] {
                result += count
            }
            memo[sum] = memo[sum, default:0] + 1
        }
        
        
        return result
    }
    
    //169. Majority Element
    func majorityElement(_ nums: [Int]) -> Int {
        var memo = [Int:Int]()
        
        for num in nums {
            memo[num] = memo[num, default:0] + 1
            if memo[num]! > nums.count/2 {
                return num
            }
        }
        return -1
    }
    
    //884. Uncommon Words from Two Sentences
    func uncommonFromSentences(_ A: String, _ B: String) -> [String] {
        var result = [String]()
        var memo = [String: Int]()
        
        var A = A.split(separator:" ").map({ String($0) })
        var B = B.split(separator:" ").map({ String($0) })
        
        for word in A {
            if let count = memo[word] {
                //Duplicate not qualify
                memo[word] = -1
            } else {
                memo[word] = 1
            }
        }
        
        for word in B {
            if let count = memo[word] {
                //Duplicate not qualify
                memo[word] = -1
            } else {
                memo[word] = 1
            }
        }
        
        for key in memo.keys where memo[key] == 1 {
            result.append(key)
        }
        
        return result
    }
    
    //771. Jewels and Stones

    func numJewelsInStones(_ J: String, _ S: String) -> Int {
        var result = 0
        var memo = [String:Int]()
        var J = J.map({ String($0) })
        var S = S.map({ String($0) })
        
        for s in J {
            memo[s] = memo[s, default:0] + 1
        }
        
        for s in S {
            if let count = memo[s] {
                result += 1
            }
        }
        
        return result
        
    }
    
    //2. Add Two Numbers
    /*
     Be aware of corner cases. What if l1 is empty first? what if there is still counter after the traverse?
     mockNode is alwasys a good idea to construct a list node
     */
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var p1 = l1
        var p2 = l2
        var mockNode = ListNode(0)
        var p = mockNode
        var count = 0
        
        while p1 != nil || p2 != nil {
            var val = count
            if p1 != nil {
                val += p1!.val
            }
            if p2 != nil {
                val += p2!.val
            }
            count = val/10
            val = val % 10
            p.next = ListNode(val)
            p = p.next!
            
            p1 = p1?.next
            p2 = p2?.next
        }
        
        if count == 1 {
            p.next = ListNode(count)
        }
        
        return mockNode.next
    }
    
    //203. Remove Linked List Elements
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let fakeNode = ListNode(0)
        
        fakeNode.next = head
        
        var node = fakeNode
        
        while node.next != nil {
            if node.next!.val == val {
                node.next = node.next!.next
            } else {
                node = node.next!
            }
        }
        
        return fakeNode.next
    }
    //557. Reverse Words in a String III

    func reverseWords(_ s: String) -> String {
        var words = s.map({ String($0) })
        var temp = ""
        var result = ""
        for i in (0..<words.count).reversed() {
            temp += words[i]
        }
        
        var tempArray = temp.components(separatedBy:" ")
        
        for i in (0..<tempArray.count).reversed() {
            result = result + tempArray[i]
            if i != 0 {
                result += " "
            }
        }
        
        
        return result
    }
    //463. Island Perimeter
    func islandPerimeter(_ grid: [[Int]]) -> Int {
        guard grid.count > 0 else {
            return 0
        }
        var result = 0
        
        //Return the potention perimeter for grid (i,j)
        func findPerimeter(i:Int, j:Int) -> Int {
            //Do no forget about this
            if grid[i][j] == 0 {
                return 0
            }
            var p = 0
            if j + 1 >= grid[0].count {
                p += 1
            } else if grid[i][j + 1] == 0 {
                p += 1
            }
            
            if j - 1 < 0 {
                p += 1
            } else if grid[i][j - 1] == 0 {
                p += 1
            }
            
            if i + 1 >= grid.count {
                p += 1
            } else if grid[i + 1][j] == 0 {
                p += 1
            }
            
            if i - 1 < 0 {
                p += 1
            } else if grid[i - 1][j] == 0 {
                p += 1
            }
            
            return p
        }
        
        for i in 0..<grid.count {
            for j in 0..<grid[0].count {
                result += findPerimeter(i:i, j:j)
            }
        }
        
        return result
    }
   
    //674. Longest Continuous Increasing Subsequence
    func findLengthOfLCIS(_ nums: [Int]) -> Int {
        var result = 0
        var pNum = Int.min
        var currentMax = 0
        
        for num in nums {
            if num > pNum {
                currentMax += 1
            } else {
                result = max(currentMax, result)
                //Not 0. Because each sequnce starts with 1
                currentMax = 1
            }
            pNum = num
        }
        
        //Note here return result will cause error if the LCIS ends with last element
        return max(currentMax, result)
        
    }
    
    //11. Container With Most Water
    //https://leetcode.com/problems/container-with-most-water/description/
    /* We define the area between index i and j as dp[i][j]
     We start from i = 0, j = n. If h[0] < h[n] that means all dp between 0 and n is smaller than dp[0][n], because i is the bottle neck.
     Then we move the bottle neck with i += 1. If here h[1] > h[n] then all dp between 1 and n is smaller than dp[1][n].
     By doing this ,we actually check all dp[i][j], and we find the maximum value
     */
    func maxArea(_ height: [Int]) -> Int {
        guard height.count > 0 else {
            return 0
        }
        
        var result = 0
        
        var i = 0
        var j = height.count - 1
        
        while i < j {
            result = max(result, min(height[i], height[j]) * (j - i))
            if height[i] < height[j] {
                i += 1
            } else {
                j -= 1
            }
        }
        
        return result
    }
    
    //253. Meeting Rooms II
    //https://leetcode.com/problems/meeting-rooms-ii/discuss/67855/Explanation-of-%22Super-Easy-Java-Solution-Beats-98.8%22-from-%40pinkfloyda
    func minMeetingRooms(_ intervals: [Interval]) -> Int {
        var starts = [Int]()
        var ends = [Int]()
        
        for i in intervals {
            starts.append(i.start)
            ends.append(i.end)
        }
        
        starts.sort()
        ends.sort()
        
        var room = 0
        var endIndex = 0
        
        for i in 0..<starts.count {
            if starts[i] < ends[endIndex] {
                room += 1
            } else {
                endIndex += 1
            }
        }
        
        return room
    }
    //724. Find Pivot Index
    func pivotIndex(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return -1
        }
        
        let sum = nums.reduce(0,+)
        
        var cSum = 0
        
        for i in 0..<nums.count {
            // (sum - nums[i]) % 2 == 0 is very important as the int will be rounded and give wrong answer
            if cSum == (sum - nums[i])/2 && (sum - nums[i]) % 2 == 0{
                return i
            }
            cSum += nums[i]
        }
        
        return -1
        
    }
    
    
    //31. Next Permutation
    /*
     The target is to replace a number in nums so that the nums increase least
     1. Find the first i from the end that nums[i] < nums[i - 1]
     2. Swap the num with the closest num in i + 1..<nums.count. Note to search it in reverse order to ensure that after swap the num in i + 1..<nums.count is in descent order.
     3. Reverse any number between i + 1..<nums.count
     
     */
    func nextPermutation(_ nums: inout [Int]) {
        var index = nums.count - 1
        
        //Find the num where nums[i - 1] < nums[i]
        while index >= 1 && nums[index - 1] >= nums[index] {
            index -= 1
        }
        
        if index == 0 {
            return nums.reverse()
        }
        
        //Index is found. Now replace nums[i - 1] with the smallest number in [nums.count, nums[i]] that bigger than nums[i - 1]
        var small = Int.max
        var tIndex = index - 1
        for i in index..<nums.count {
            if nums[i] > nums[index - 1] {
                if small > nums[i] {
                    small = nums[i]
                    tIndex = i
                }
            }
        }
        
        //swap the two
        var temp = nums[index - 1]
        nums[index - 1] = nums[tIndex]
        nums[tIndex] = temp
        
        //Sort [nums.count, nums[i]]
        nums[index...nums.count - 1].sort()
        
    }
    
    //347. Top K Frequent Elements
    // Swift way: nlogn
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var memo = [Int: Int]()
        
        for num in nums {
            memo[num] = memo[num, default: 0] + 1
        }
        //Remember is you call Dictionary.sorted() then dictionary will become an array of tuple(key:T, value:T)
        // It is very covenient. (or you can all Array(Dictionary) if you do not want to sort)
        
        return Array(memo.sorted(by:{$0.1 > $1.1}).map({ $0.0 })[0..<k])
    }
    
    //Bucket sort
    func topKFrequentV2(_ nums: [Int], _ k: Int) -> [Int] {
        var bucket = Array(repeating:[Int](), count: nums.count + 1)
        var memo = [Int: Int]()
        
        for num in nums {
            memo[num] = memo[num, default: 0] + 1
        }
        
        for key in memo.keys {
            if bucket[memo[key]!].count == 0 {
                bucket[memo[key]!] = [key]
            } else {
                bucket[memo[key]!] = bucket[memo[key]!] + [key]
            }
        }
        
        var result = [Int]()
        
        
        for i in (0..<bucket.count).reversed() {
            if bucket[i].count > 0 {
                for b in bucket[i] {
                    if result.count == k {
                        return result
                    }
                    result.append(b)
                }
            }
        }
        
        return result
    }
    
    
    class MinStack {
        
        typealias Node = (val:Int, min:Int)
        var stack = [Node]()
        var small = Int.max
        
        /** initialize your data structure here. */
        init() {
            
        }
        
        func push(_ x: Int) {
            //We record the min that before the value is append
            stack.append(Node(val:x,min:small))
            small = min(small, x)
        }
        
        func pop() {
            if let node = stack.popLast() {
                small = node.min
            }
        }
        
        func top() -> Int {
            return stack.last!.val
        }
        
        func getMin() -> Int {
            return small
        }
    }
    
    
    //19. Remove Nth Node From End of List
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        //We need to use fake head here. Otherwise for the scenarios such as" [1] 1" we will have error.
        var fakeHead = ListNode(0)
        
        var begin: ListNode? = fakeHead
        var end: ListNode? = fakeHead
        fakeHead.next = head
        
        for i in 0..<n {
            end = end?.next
        }
        
        while end?.next != nil {
            begin = begin?.next
            end = end?.next
        }
        
        begin?.next = begin?.next?.next
        
        return fakeHead.next
        
    }
    //448. Find All Numbers Disappeared in an Array

    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        guard nums.count > 0 else {
            return [Int]()
        }
        var memo = [Int:Int]()
        var result = [Int]()
        for num in nums {
            memo[num] = memo[num, default:0] + 1
        }
        
        for i in 1...nums.count {
            if memo[i] == nil {
                result.append(i)
            }
        }
        
        return result
    }
    //221. Maximal Square
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        guard matrix.count > 0 else {
            return 0
        }
        //DP max size of square can be archived at [i, j]
        var dp = Array(repeating:Array(repeating:-1, count:matrix[0].count), count:matrix.count)
        
        var result = 0
        
        for i in 0..<matrix.count {
            dp[i][0] = matrix[i][0] == "0" ? 0 : 1
            result = max(dp[i][0], result)
        }
        
        for j in 0..<matrix[0].count {
            dp[0][j] = matrix[0][j] == "0" ? 0 : 1
            result = max(dp[0][j], result)
        }
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[0].count {
                if i == 0 || j == 0 {
                    continue
                }
                if matrix[i][j] == "1" {
                    dp[i][j] = min(min(dp[i - 1][j], dp[i][j - 1]), dp[i - 1][j - 1]) + 1
                    result = max(result, dp[i][j])
                } else {
                    dp[i][j] = 0
                }
            }
        }
        return result * result
    }
    
    //114. Flatten Binary Tree to Linked List

    func flatten(_ root: TreeNode?) {
        var stack = [TreeNode]()
        
        func fTree(_ root: TreeNode?)  {
            guard let n = root else {
                return
            }
            
            //Put the right tree into stack, traverse the trees left node first
            if let right = n.right {
                stack.append(right)
            }
            
            //Swap left and right based on the requirement
            n.right = n.left
            
            //Remove the left
            n.left = nil
            
            //If n has right, continue visit
            if let cRight = n.right {
                fTree(cRight)
                //If n ran out of right node, pop one from the stack to continue visit
            } else {
                n.right = stack.popLast()
                fTree(n.right)
            }
        }
        
        fTree(root)
    }
    //287. Find the Duplicate Number

    func findDuplicate(_ nums: [Int]) -> Int {
        var sNums = nums.sorted()
        for i in 0..<sNums.count {
            if sNums[i + 1] == sNums[i] {
                return sNums[i]
            }
        }
        
        return -1
    }
    
    //48. Rotate Image
    // DO NOT SPEND TIME ON THE ALGORITHM THAT WOULD COST YOU FOREVER TO FIGUREOUT.
    // The genera way is so easy if you know how to do it properly
    func rotate(_ matrix: inout [[Int]]) {
        matrix.reverse()
        
        for i in 0..<matrix.count {
            for j in i + 1..<matrix[0].count {
                let temp = matrix[i][j]
                matrix[i][j] = matrix[j][i]
                matrix[j][i] = temp
            }
        }
    }
    
    //394. Decode String
    func decodeString(_ s: String) -> String {
        var result = ""
        var sArray = s.map({ String($0)})
        
        func dString(_ s:[String]) {
            var num = "0123456789"
            var count = 0
            var cIndex = 0
            var currentString = [String]()
            var newString = [String]()
            var i = 0
            
            while i < s.count {
                if num.contains(s[i]) {
                    cIndex = i
                    count = 0
                    while num.contains(s[i]) {
                        count = 10 * count + Int(s[i])!
                        i += 1
                    }
                    currentString = [String]()
                    i += 1
                } else if s[i] == "[" {
                    i += 1
                    continue
                } else if s[i] == "]" {
                    for _ in 0..<count {
                        newString += currentString
                    }
                    
                    newString = s[0..<cIndex] + newString
                    if i < s.count {
                        newString += s[i + 1..<s.count]
                    }
                    count = 0
                    break
                } else {
                    currentString.append(s[i])
                    i += 1
                }
            }
            
            if newString.count > 0 {
                dString(newString)
            } else {
                result = s.joined(separator:"")
            }
        }
        
        dString(sArray)
        
        return result
        
    }
    
    //279. Perfect Squares

    func numSquares(_ n: Int) -> Int {
        //Time exceeded
        //         var dp = Array(repeating:Int.max, count:n + 1)
        
        //         dp[0] = 0
        
        //         for i in 1...n {
        //             for j in 1...i where j*j <= i {
        // dp[i] has to be consisted of number i - j*j and a perfect square i
        //                 dp[i] = min(dp[i - j*j] + 1, dp[i])
        //             }
        //         }
        
        //         return dp.last!
        
        //Build from bottom
        
        var dp = [0]
        
        while dp.count <= n {
            var size = dp.count
            var cSquare = Int.max
            for i in 1...size where i*i <= size {
                cSquare = min(cSquare, dp[size - i * i] + 1)
            }
            dp.append(cSquare)
        }
        
        return dp.last!
    }
    
    //5. Longest Palindromic Substring
    // O(n^2)
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 0 else {
            return ""
        }
        /*
         dp[i][j]: whether the sub string between index i and j is a palindrome.
         dp[i][j] is true if the s[i] == s[j] dp[i + 1][j - 1] is a palindrome.
         Also consider the senario that j - i < s (e.g.'aba' or 'aa') then as long as s[i] == s[j]
         dp[i][j] is true.
         Thus dp[i][j] = (s[i] == s[j]) && (j - i < 3 || dp[i + 1][j - 1])
         */
        
        var dp = Array(repeating:Array(repeating:false,count:s.count),count:s.count)
        
        var sArray = s.map({ String($0) })
        
        var low = 0
        var high = 0
        
        for j in 0..<sArray.count{
            for i in 0...j {
                if i == j {
                    dp[i][j] = true
                    continue
                } else {
                    //Note j - i < 3
                    dp[i][j] = (sArray[i] == sArray[j]) && (j - i < 3 || dp[i + 1][j - 1])
                    if dp[i][j] == true && j - i > high - low {
                        low = i
                        high = j
                    }
                }
            }
        }
        
        return Array(sArray[low...high]).joined()
        
        
    }
    
    //152. Maximum Product Subarray
    //O(n)
    /*
     If the nums are all positive, then it is easy because the product of all
     the element of nums is the biggest value. However nums may contain negative value.
     We need to remember the biggest value as well as smallest value (should be a negative value).
     In the case of nums[i] < 0, then the smallest value multiple by nums[i] will become the largest value.
     
     */
    func maxProduct(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        
        var large = nums[0]
        var small = nums[0]
        var result = nums[0]
        
        for i in 1..<nums.count {
            //Note here we need a temp. Other wise the first line will pollute large and give wrong answer
            var temp = large
            large = max(max(small * nums[i], large * nums[i]), nums[i])
            small = min(min(small * nums[i], temp * nums[i]), nums[i])
            result = max(large, result)
        }
        
        return result
    }
    
    //75. Sort Colors
    // O(n)
    func sortColors(_ nums: inout [Int]) {
        var memo = Array(repeating: 0, count:3)
        for num in nums {
            if num == 0 {
                memo[0] += 1
            } else if num == 1 {
                memo[1] += 1
            } else {
                memo[2] += 1
            }
        }
        
        for i in 0..<nums.count {
            if i < memo[0] {
                nums[i] = 0
            } else if i < memo[0] + memo[1] {
                nums[i] = 1
            } else {
                nums[i] = 2
            }
        }
    }
    
    //148. Sort List
    func sortList(_ head: ListNode?) -> ListNode? {
        var nums = [Int]()
        var node = head
        
        while node != nil {
            nums.append(node!.val)
            node = node!.next
        }
        
        nums.sort()
        
        var mockNode = ListNode(0)
        node = mockNode
        
        //Do not directly change node otherwise error will occure
        for num in nums {
            node?.next = ListNode(num)
            node = node?.next
        }
        
        return mockNode.next
        
    }
    
    //39. Combination Sum
    //For each num in the candicates, we could take 1 of the num, or 2 of the nums...as long as n * num <= target. if n * num == target, a path is find, put all the nums to the path and add a new result. otherwise, keep searching in the second candidates with what remains when 1 of the num, or 2 of the nums... were taken. Until all the nums are find
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        guard candidates.count > 0 else {
            return [[Int]]()
        }
        
        var result = [[Int]]()
        
        typealias Path = (remain:Int, pre:[Int])
        
        func findMatch(paths:[Path], cIndex:Int) {
            if paths.count == 0 || cIndex == candidates.count {
                return
            }
            var newPaths = [Path]()
            for path in paths {
                var count = 0
                while candidates[cIndex] * count <= path.remain {
                    var newPre = path.pre
                    for _ in 0..<count {
                        newPre.append(candidates[cIndex])
                    }
                    
                    let newPath = (remain: path.remain - candidates[cIndex] * count, pre:newPre)
                    
                    if newPath.remain == 0 {
                        result.append(newPre)
                    } else {
                        newPaths.append(newPath)
                    }
                    count += 1
                }
            }
            findMatch(paths:newPaths,cIndex: cIndex + 1)
        }
        
        findMatch(paths:[Path(remain:target, pre:[Int]())], cIndex:0)
        
        return result
    }
    
    //Back tracking solution
    func combinationSumV2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        guard candidates.count > 0 else {
            return [[Int]]()
        }
        
        var result = [[Int]]()
        
        
        func findMatch(candidates:[Int], target: Int, index: Int, path:[Int]) {
            if target <= 0 {
                if target == 0 {
                    result.append(path)
                }
                return
            }
            
            for i in index..<candidates.count {
                var num = candidates[i]
                if num > target {
                    continue
                }
                findMatch(candidates:candidates, target: target - num, index: i, path:path + [num])
            }
        }
        
        findMatch(candidates:candidates, target: target, index: 0, path:[Int]())
        
        return result
    }
    
    //90. Subsets II
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        
        var result = [[Int]]()
        
        var nums = nums.sorted()
        
        func backtrace(nums:[Int], path:[Int], index:Int) {
            result.append(path)
            for i in index..<nums.count {
                if i > index && nums[i] == nums[i - 1] {
                    continue
                }
                // Note index: i + 1
                backtrace(nums:nums,path:path + [nums[i]], index:i + 1)
            }
        }
        
        backtrace(nums:nums, path:[Int](), index:0)
        return result
    }
    
    //240. Search a 2D Matrix II
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard matrix.count > 0 && matrix[0].count > 0 else {
            return false
        }
        //Practice binary search more
        func bSearch(nums:[Int], target: Int) -> Bool {
            var l = 0
            var h = nums.count - 1
            
            while l <= h {
                let m = l + (h - l)/2
                if target < nums[m] {
                    h = m - 1
                } else if target > nums[m] {
                    l = m + 1
                } else {
                    return true
                }
            }
            
            return false
        }
        
        for column in matrix {
            if target > column.last! || target < column.first! {
                continue
            }
            if bSearch(nums:column, target:target) {
                return true
            }
        }
        
        return false
    }
    
    //547. Friend Circles
    /*
    The relationship between friend consists a graph with adjcent matrix.
    In order to find how many isolated group in the matrix, we need to traver from each people.
     if a people is visited, means he is friend of some previous person, we skip. otherwise a new
     friend circle is found.
     */
    func findCircleNum(_ M: [[Int]]) -> Int {
        var visited = Array(repeating: false, count: M.count)
        var result = 0
        
        func dfsGraph(adjMatrix:[[Int]], size: Int, i: Int) {
            //This column should be marked as visited
            visited[i] = true
            for j in 0..<size {
                if !visited[j] && adjMatrix[i][j] == 1 {
                    //If some index in that column is unvisited, we jump to visit that column.
                    dfsGraph(adjMatrix: adjMatrix, size: size, i: j)
                }
            }
        }
        
        
        for i in 0..<M.count {
            if !visited[i] {
                result += 1
                dfsGraph(adjMatrix:M, size: M.count, i: i)
            }
        }
        
        return result
    }
    
    //695. Max Area of Island
    // Samilar to previous question. We traverse the map to find the valid graph, calculate the max area of each graph takes. Then compare to the answer
    func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
        var visited = Array(repeating:Array(repeating:false,count:grid[0].count), count:grid.count)
        var result = 0
        var currentMax = 0
        
        func dfs(i: Int, j:Int) {
            visited[i][j] = true
            currentMax += 1
            if i + 1 < visited.count && grid[i + 1][j] == 1 && !visited[i + 1][j] {
                dfs(i:i + 1, j: j)
            }
            
            //Note it is >= 0 not > 0 as grid[0] is still valid
            if i - 1 >= 0 && grid[i - 1][j] == 1 && !visited[i - 1][j]{
                dfs(i:i - 1, j: j)
            }
            
            //Note visited[0] not visited
            if j + 1 < visited[0].count && grid[i][j + 1] == 1 && !visited[i][j + 1] {
                dfs(i:i, j: j + 1)
            }
            
            if j - 1 >= 0 && grid[i][j - 1] == 1 && !visited[i][j - 1] {
                dfs(i:i, j: j - 1)
            }
        }
        
        
        for i in 0..<grid.count {
            for j in 0..<grid[0].count {
                if !visited[i][j] && grid[i][j] == 1 {
                    currentMax = 0
                    dfs(i:i, j:j)
                    result = max(currentMax, result)
                }
            }
        }
        
        return result
    }
    
    //16. 3Sum Closest
    // We traverse the sorted nums, find the sum: num[i] + nums[low] + nums[high] that closest to the target
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 2 else {
            return 0
        }
        
        var nums = nums
        
        nums.sort()
        
        var result = nums[0] + nums[1] + nums[nums.count - 1]
        
        for i in 0..<nums.count - 2 {
            let num = nums[i]
            var low = i + 1
            var high = nums.count - 1
            while low < high {
                let sum = num + nums[low] + nums[high]
                if sum > target {
                    high -= 1
                } else {
                    low += 1
                }
                
                if abs(target - sum) < abs(target - result) {
                    result = sum
                }
            }
        }
        
        return result
    }
    //54. Spiral Matrix
    //Pay attention to the relationship between x, y and i, j. Remember i is row and j is column
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        guard matrix.count > 0 && matrix[0].count > 0 else {
            return [Int]()
        }
        
        var memo = Array(repeating:Array(repeating:false, count:matrix[0].count), count:matrix.count)
        
        typealias Coordinate = (x: Int, y:Int)
        var coordinates = [Coordinate(x:1, y:0),
                           Coordinate(x:0, y:1),
                           Coordinate(x:-1, y:0),
                           Coordinate(x:0, y:-1)]
        
        
        func traverse(i:Int, j:Int, cResult:[Int], coIndex: Int) -> [Int] {
            if i < 0 || j < 0 || i >= matrix.count || j >= matrix[0].count || memo[i][j] == true {
                return cResult
            }
            
            var cResult = cResult
            var i = i
            var j = j
            while i < matrix.count && i >= 0 && j < matrix[0].count && j >= 0 && memo[i][j] != true {
                cResult.append(matrix[i][j])
                memo[i][j] = true
                i += coordinates[coIndex].y
                j += coordinates[coIndex].x
            }
            
            i -= coordinates[coIndex].y
            j -= coordinates[coIndex].x
            
            let newCo = (coIndex + 1)%4
            
            i += coordinates[newCo].y
            j += coordinates[newCo].x
            
            
            return traverse(i: i,
                            j: j,
                            cResult:cResult,
                            coIndex: newCo)
        }
        
        return traverse(i:0, j:0, cResult:[Int](), coIndex:0)
        
    }
    
    //53. Maximum Subarray
    func maxSubArray(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        //DP: Max sum that ends with index i
        var dp = Array(repeating:0, count:nums.count)
        var result = nums[0]
        dp[0] = nums[0]
        
        for i in 1..<nums.count {
            dp[i] = nums[i] + (dp[i - 1] > 0 ? dp[i - 1] : 0)
            result = max(dp[i], result)
        }
        return result
    }
    
    //582. Kill Process V1
    func killProcessV1(_ pid: [Int], _ ppid: [Int], _ kill: Int) -> [Int] {
        guard pid.count > 0 && ppid.count > 0 else {
            return [Int]()
        }
        
        var memo = [Int: [Int]]()
        var result = [kill]
        
        for i in 0..<ppid.count {
            memo[ppid[i]] = memo[ppid[i], default:[Int]()] + [pid[i]]
        }
        
        
        func killP(pid:[Int], ppid:[Int], kill:Int) {
            guard let pToKill = memo[kill] else {
                return
            }
            
            for p in pToKill {
                result.append(p)
                killP(pid:pid, ppid:ppid, kill:p)
            }
        }
        
        killP(pid:pid, ppid:ppid, kill:kill)
        
        return result
    }
    
    //582. Kill Process bfs
    func killProcess(_ pid: [Int], _ ppid: [Int], _ kill: Int) -> [Int] {
        guard pid.count > 0 && ppid.count > 0 else {
            return [Int]()
        }
        
        var memo = [Int: [Int]]()
        var result = [Int]()
        
        //It is important to prepare for the candidates here
        for i in 0..<ppid.count {
            memo[ppid[i]] = memo[ppid[i], default:[Int]()] + [pid[i]]
        }
        
        
        var queue = [Int]()
        queue.append(kill)
        
        while queue.count > 0 {
            let p = queue.removeLast()
            result.append(p)
            if let newP = memo[p] {
                queue += newP
            }
        }
        
        
        return result
    }
    
    //249. Group Shifted Strings
    func groupStrings(_ strings: [String]) -> [[String]] {
        guard strings.count > 0 else {
            return [[String]]()
        }
        
        var chars = "abcdefghijklmnopqrstuvwxyz".map{ String($0) }
        var memo = [String:Int]()
        var result = [[String]]()
        
        for i in 0..<chars.count {
            memo[chars[i]] = i
        }
        
        func unifyString(string: String) -> String {
            guard string.count > 0 else {
                return ""
            }
            var sArray = string.map{ String($0) }
            let d = memo[sArray[0]]!
            
            sArray = sArray.map{ (char) -> String in
                var distance = memo[char]! - d
                //This is very important for case "az" "ba"
                if distance < 0 {
                    distance = distance + 26
                }
                
                return chars[distance]
            }
            
            return sArray.joined()
        }
        
        var dict = [String: [String]]()
        for s in strings {
            let unifiedString = unifyString(string:s)
            if let cStrings = dict[unifiedString] {
                dict[unifiedString] = cStrings + [s]
            } else {
                dict[unifiedString] = [s]
            }
        }
        
        for key in dict.keys {
            result.append(dict[key]!)
        }
        return result
    }
    
    //208. Implement Trie (Prefix Tree)
    class Trie {
        let head: TrieNode
        /** Initialize your data structure here. */
        init() {
            //We need a starting head node
            self.head = TrieNode(val:"*")
        }
        
        /** Inserts a word into the trie. */
        func insert(_ word: String) {
            var word = word.map{ String($0) }
            var cNode = self.head
            for char in word {
                //For each char in word, we look for if current node matches the charater
                if let nNode = cNode.children[char] {
                    //If cNode has current value, continue
                    cNode = nNode
                } else {
                    //if the path does no exist, create a new node
                    let nNode = TrieNode(val:char)
                    cNode.children[char] = nNode
                    cNode = nNode
                }
            }
            //This is important. other wise for trie "a->p->p->l->e", when search for "app".
            //It will incorrectly return true. For each word we insert, we must give a closure
            cNode.children["end"] = TrieNode(val:"*")
        }
        
        /** Returns if the word is in the trie. */
        func search(_ word: String) -> Bool {
            var word = word.map{ String($0) }
            var cNode = self.head
            for char in word {
                if let nNode = cNode.children[char] {
                    cNode = nNode
                } else {
                    return false
                }
            }
            //Check if the word ends here.
            return cNode.children["end"] != nil
        }
        
        /** Returns if there is any word in the trie that starts with the given prefix. */
        func startsWith(_ prefix: String) -> Bool {
            var prefix = prefix.map{ String($0) }
            var cNode = self.head
            for char in prefix {
                if let nNode = cNode.children[char] {
                    cNode = nNode
                } else {
                    return false
                }
            }
            return true
        }
    }
    
    class TrieNode {
        let val: String
        var children = [String: TrieNode]()
        
        public init(val: String) {
            self.val = val
        }
    }
    
    
    //238. Product of Array Except Self

    func productExceptSelf(_ nums: [Int]) -> [Int] {
        guard nums.count > 0 else {
            return [Int]()
        }
        
        var result = [Int]()
        var left = [nums.first!]
        var right = [nums.last!]
        
        for i in 1..<nums.count {
            left.append(nums[i] * left[i - 1])
            right.insert(nums[nums.count - i - 1] * right[0], at:0)
        }
        
        for i in 0..<nums.count {
            if i == 0 {
                result.append(right[1])
            } else if i == nums.count - 1 {
                result.append(left[nums.count - 2])
            } else {
                result.append(left[i - 1] * right[i + 1])
            }
        }
        
        return result
        
    }
    
    //348. Design Tic-Tac-Toe
    class TicTacToe {
        var columns : [Int]
        var rows : [Int]
        var diagonal: Int
        var antiDiagonal: Int
        /** Initialize your data structure here. */
        init(_ n: Int) {
            self.rows = [Int](repeating: 0, count:n)
            self.columns = [Int](repeating: 0, count:n)
            self.diagonal = 0
            self.antiDiagonal = 0
        }
        
        /** Player {player} makes a move at ({row}, {col}).
         @param row The row of the board.
         @param col The column of the board.
         @param player The player, can be either 1 or 2.
         @return The current winning condition, can be either:
         0: No one wins.
         1: Player 1 wins.
         2: Player 2 wins. */
        func move(_ row: Int, _ col: Int, _ player: Int) -> Int {
            let toMove = player == 1 ? 1 : -1
            rows[row] += toMove
            columns[col] += toMove
            
            if row == col {
                diagonal += toMove
            }
            
            if col == rows.count - row - 1 {
                antiDiagonal += toMove
            }
            
            let t = rows.count
            
            if abs(rows[row]) == t || abs(columns[col]) == t || abs(diagonal) == t || abs(antiDiagonal) == t {
                return player
            } else {
                return 0
            }
        }
    }
    
    //202. Happy Number
    func isHappy(_ n: Int) -> Bool {
        guard n > 0 else {
            return false
        }
        
        var memo = [Int: Bool]()
        
        func getNextNum(num: Int) -> Bool {
            if num == 1 {
                return true
            } else if memo[num] == true {
                return false
            }
            
            memo[num] = true
            
            var digits = [Int]()
            var num = num
            while num > 0 {
                digits.append(num % 10)
                num /= 10
            }
            
            for digit in digits {
                num += digit * digit
            }
            
            return getNextNum(num: num)
        }
        
        return getNextNum(num: n)
    }
    
    //206. Reverse Linked List
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard let node = head else {
            return nil
        }
        
        var pre: ListNode? = nil
        var current = head
        
        while current != nil {
            let next = current!.next
            current!.next = pre
            pre = current
            current = next
        }
        
        return pre
    }

    
    //179. Largest Number

    func largestNumber(_ nums: [Int]) -> String {
        guard nums.count > 0 else {
            return ""
        }
        
        var n = nums.map({ String($0) })
        
        n.sort { (n1, n2) -> Bool in
            let s1 = Int(n1 + n2)!
            let s2 = Int(n2 + n1)!
            return s1 > s2
        }
        
        
        let result = n.joined()
        
        
        return n[0] == "0" ? "0" : result
    }
    
    //124. Binary Tree Maximum Path Sum
    /*
    In the maxiumDown, each input node has two responsibility.
     First calculate the max value starting from this node. The second
     is to provide a path (either right or left), including itself, for the upper
     node to use.
     */
    func maxPathSum(_ root: TreeNode?) -> Int {
        var result = Int.min
        
        
        func maxiumDown(cNode: TreeNode?) -> Int {
            guard let n = cNode else {
                return 0
            }
            let left = max(maxiumDown(cNode:n.left), 0)
            let right = max(maxiumDown(cNode:n.right), 0)
            result = max(result, left + right + n.val)
            
            return max(left,right) + n.val
        }
        
        maxiumDown(cNode: root)
        
        
        return result
    }
    //209. Minimum Size Subarray Sum
    //Sliding window
    func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        
        var result = Int.max
        
        var start = 0
        var end = 0
        
        var sum = nums[0]
        
        while end < nums.count {
            if sum < s {
                end += 1
                if end < nums.count {
                    sum += nums[end]
                }
            } else {
                if start == end {
                    return 1
                }
                
                result = min(result, end - start + 1)
                sum -= nums[start]
                start += 1
            }
        }
        
        return result == Int.max ? 0 : result
        
    }
    
    //733. Flood Fill
    func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
        guard image.count > 0 && image[0].count > 0 else {
            return [[Int]]()
        }
        
        var image = image
        
        var visited = [[Bool]](repeating:[Bool](repeating:false, count:image[0].count), count: image.count)
        
        let oldColor = image[sr][sc]
        
        func fillNode(r: Int, c: Int) {
            if r < 0 || c < 0 || r >= image.count || c >= image[0].count || visited[r][c] == true || image[r][c] != oldColor
            {
                return
            }
            
            visited[r][c] = true
            image[r][c] = newColor
            fillNode(r:r, c:c + 1)
            fillNode(r:r, c:c - 1)
            fillNode(r:r + 1, c:c)
            fillNode(r:r - 1, c:c)
        }
        
        fillNode(r:sr, c:sc)
        return image
    }
    
    //289. Game of Life
    func gameOfLife(_ board: inout [[Int]]) {
        guard board.count > 0 && board[0].count > 0 else {
            return
        }
        
        var result = [[Int]](repeating:[Int](repeating:-1, count: board[0].count), count: board.count)
        
        func nextStatus(i:Int, j:Int) -> Int {
            var liveN = 0
            let directions = [[0, 1],
                              [0, -1],
                              [1, 0],
                              [-1, 0],
                              [1, 1],
                              [-1, -1],
                              [1, -1],
                              [-1, 1]]
            for d in directions {
                if isAlive(i: i + d[0], j: j + d[1]) {
                    liveN += 1
                }
            }
            
            if liveN < 2 && board[i][j] == 1{
                return 0
            } else if liveN > 3 && board[i][j] == 1 {
                return 0
            } else if liveN == 3 && board[i][j] == 0 {
                return 1
            }
            return board[i][j]
        }
        
        func isAlive(i:Int, j:Int) -> Bool {
            if i < 0 || j < 0 || i >= board.count || j >= board[0].count || board[i][j] == 0 {
                return false
            } else {
                return board[i][j] == 1
            }
        }
        
        for r in 0..<board.count {
            for c in 0..<board[0].count {
                result[r][c] = nextStatus(i:r, j:c)
            }
        }
        
        board = result
    }

    //412. Fizz Buzz
    func fizzBuzz(_ n: Int) -> [String] {
        guard n > 0 else {
            return [String]()
        }
        
        var result = [String]()
        
        for i in 0..<n {
            if (i + 1) % 15 == 0 {
                result.append("FizzBuzz")
            } else if (i + 1) % 3 == 0 {
                result.append("Fizz")
            } else if (i + 1) % 5 == 0 {
                result.append("Buzz")
            } else {
                result.append(String(i + 1))
            }
        }
        
        return result
    }
    
    //91. Decode Ways

    func numDecodings(_ s: String) -> Int {
        if s.count == 0 {
            return 0
        } else if s.count == 1 {
            return s == "0" ? 0 : 1
        }
        
        var s = s.map({ String($0) })
        if s[0] == "0" {
            return 0
        }
        var dp = [Int](repeating: 0, count: s.count + 1)
        dp[0] = 1
        dp[1] = s[0] == "0" ? 0 : 1
        
        var i = 2
        while i <= s.count {
            let first = Int(s[i - 1])!
            let two = Int(s[i - 2] + s[i - 1])!
            if first >= 1 && first <= 9 {
                dp[i] += dp[i - 1]
            }
            
            if two >= 10 && two <= 26 {
                dp[i] += dp[i - 2]
            }
            i += 1
        }
        
        return dp[s.count]
    }
    
    //844. Backspace String Compare
    //O(m + n)
    //if we allow O(3N) that is easy. call getRealString for each string then compare.
    //The tricky part is if we only allowed to us O(M + N), then we get the valid string for
    //one string and check another one
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        var sArray = S.map({ String($0) })
        var tArray = T.map({ String($0) })
        
        func getRealString(string: [String]) -> [String] {
            var queue = [String]()
            for i in 0..<string.count {
                if string[i] == "#" {
                    if queue.count > 0 {
                        queue.removeLast()
                    }
                } else {
                    queue.append(string[i])
                }
            }
            return queue
        }
        
        let temp = getRealString(string: sArray)
        
        //We use a cache to record the space "debt"
        var bCache = 0
        var i = tArray.count - 1
        var j = temp.count  - 1
        
        //Now we have the actual string. going backwards to check if another string matchs
        while i >= 0 && j >= 0 {
            if tArray[i] == "#" {
                bCache += 1
                i -= 1
            } else if bCache > 0 {
                bCache -= 1
                i -= 1
            } else if tArray[i] != temp[j] {
                return false
            } else {
                i -= 1
                j -= 1
            }
        }
        
        if i < 0 && j < 0 {
            return true
        } else if i < 0 {
            return false
        } else {
            //The other string still has numbers. check if eventually it becomes empty
            return getRealString(string: Array(tArray[0...i])).count == 0
        }
    }
    
    //735. Asteroid Collision
    func asteroidCollision(_ asteroids: [Int]) -> [Int] {
        guard asteroids.count > 0 else {
            return [Int]()
        }
        
        var queue = [Int]()
        
        for i in 0..<asteroids.count {
            //only + and - will collide
            if queue.count > 0 {
                let left = queue.last!
                let right = asteroids[i]
                if left > 0 && right < 0 {
                    //collid
                    if left == abs(right) {
                        //Both explode
                        queue.removeLast()
                    } else {
                        while queue.count > 0 && queue.last! < abs(right) && queue.last! > 0 {
                            queue.removeLast()
                        }
                        
                        if queue.count == 0 || queue.last! < 0 {
                            queue.append(right)
                        } else if queue.last! == abs(right) {
                            queue.removeLast()
                        }
                    }
                } else {
                    queue.append(right)
                }
            } else {
                queue.append(asteroids[i])
            }
        }
        return queue
    }
    //501. Find Mode in Binary Search Tree
    //Remember that in order traverse a binary tree will give you decend order nums. then we will get something like [1, 2, 2, 3, 4, 4, 5]
    func findMode(_ root: TreeNode?) -> [Int] {
        guard let node = root else {
            return [Int]()
        }
        
        var result = [Int]()
        
        var preCount = 1
        var max = Int.min
        var preValue = 0
        var isFirst = true
        
        func traverse(n: TreeNode?) {
            guard let tNode = n else {
                return
            }
            
            traverse(n: tNode.left)
            if isFirst {
                isFirst = false
            } else if tNode.val != preValue {
                if preCount > max {
                    result.removeAll()
                    result.append(preValue)
                    max = preCount
                } else if preCount == max {
                    result.append(preValue)
                }
                preCount = 1
            } else {
                preCount += 1
            }
            preValue = tNode.val
            traverse(n: tNode.right)
        }
        
        traverse(n: node)
        
        if preCount > max {
            result.removeAll()
            result.append(preValue)
            max = preCount
        } else if preCount == max {
            result.append(preValue)
        }
        
        return result
    }
    
    //389. Find the Difference
    //(O(n))
    // Another approach is to sort both string and compare them one element by one element.
    // In that case the time complexity is O(nlogn)
    func findTheDifference(_ s: String, _ t: String) -> Character {
        var sArray = s.map( {String($0)} )
        var tArray = t.map( {String($0)} )
        var memo = [String:Int]()
        var result = ""
        
        for i in 0..<sArray.count {
            memo[sArray[i]] = memo[sArray[i], default: 0] + 1
        }
        
        for j in 0..<tArray.count {
            guard let charCount  = memo[tArray[j]] else {
                result = tArray[j]
                return Character(result)
            }
            
            memo[tArray[j]] = charCount - 1
            if charCount - 1 < 0 {
                result = tArray[j]
            }
            
        }
        
        return Character(result)
    }
    
    //290. Word Pattern
    func wordPattern(_ pattern: String, _ str: String) -> Bool {
        if pattern.count == 0 && str.count == 0 {
            return true
        }
        
        guard pattern.count > 0, str.count > 0 else {
            return false
        }
        var memo = [String: String]()
        var registered = [String: Bool]()
        
        let pArray = pattern.map{ String($0) }
        let sArray = str.components(separatedBy:" ")
        
        if pArray.count != sArray.count {
            return false
        }
        
        for i in 0..<pArray.count {
            if let match = memo[pArray[i]] {
                if match != sArray[i] {
                    return false
                }
                registered[match] = true
            } else {
                if registered[sArray[i]] != nil {
                    return false
                } else {
                    memo[pArray[i]] = sArray[i]
                    registered[sArray[i]] = true
                }
            }
        }
        
        return true
    }
    
    //395. Longest Substring with At Least K Repeating Characters
    //Use any invalid char as splitter, until the string cannot be splite anymore
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        guard s.count > 0 else {
            return 0
        }
        
        guard k > 0 else {
            return s.count
        }
        
        var result = Int.min
        var sArray = s.map{ String($0) }
        
        func splitString(string: [String]) {
            guard string.count > 0 else {
                return
            }
            var memo = [String: Int]()
            var invalidChar = [String]()
            for i in 0..<string.count {
                memo[string[i]] = memo[string[i], default:0] + 1
            }
            
            var candidates = [[String]]()
            var last = -1
            var i = 0
            while i < string.count  {
                if memo[string[i]]! < k {
                    if i <= last + 1 {
                        last = i
                        i += 1
                        continue
                    } else {
                        candidates.append(Array(string[last + 1..<i]))
                        last = i
                    }
                }
                i += 1
            }
            
            if last < string.count - 1{
                candidates.append(Array(string[last + 1..<string.count]))
            }
            
            if last == -1 {
                result = max(string.count, result)
                return
            }
            
            for c in candidates {
                splitString(string:c)
            }
        }
        
        splitString(string:sArray)
        return result == Int.min ? 0 : result
    }
    
    //110. Balanced Binary Tree
    //findMaxDepth has two responsibility: provide the max depth for the parent node, and check if current diff exceeds the boundry
    func isBalanced(_ root: TreeNode?) -> Bool {
        guard let rootNode = root else {
            return true
        }
        
        var result = true
        
        func findMaxDepth(root: TreeNode?) -> Int {
            guard let node = root else {
                return 0
            }
            
            var left = findMaxDepth(root:node.left)
            var right = findMaxDepth(root:node.right)
            let diff = abs(left - right)
            if diff >= 2 {
                result = false
            }
            return max(left, right) + 1
        }
        
        let maxD = findMaxDepth(root:rootNode)
        
        return result
        
    }
    
    //Use dynamic programing. For each element j in row i, the min sum is decided by  min(dp[j], dp[j - 1]), we keep building the dp to fill the last layer, then traverse it to find the min
    //Time: O(n) n is the total num of elements in the trangle
    //Space: O(n) n is the maxMium num of elements in each row
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        guard triangle.count > 0, triangle[0].count > 0 else {
            return 0
        }
        
        if triangle.count == 1 {
            return triangle[0][0]
        }
        
        var dp = [triangle[0][0]]
        
        for i in 1..<triangle.count {
            var temp = [Int](repeating:0,count:triangle[i].count)
            for j in 0..<triangle[i].count {
                if j == 0 {
                    temp[j] = dp[j] + triangle[i][j]
                } else if j == triangle[i].count - 1 {
                    temp[j] = dp[j - 1] + triangle[i][j]
                } else {
                    temp[j] = min(dp[j], dp[j - 1]) + triangle[i][j]
                }
            }
            dp = temp
        }
        
        var minNum = Int.max
        
        for num in dp {
            minNum = min(minNum, num)
        }
        
        return minNum
    }
    
    //491. Increasing Subsequences
    //The key is to find the right pattern
    func findSubsequences(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 1 else {
            return [[Int]]()
        }
        
        var result = [[Int]]()
        
        func helper(array:[Int], index: Int) {
            if array.count > 1 {
                result.append(array)
            }
            
            if index > nums.count {
                return
            }
            
            //User memo to eliminate duplicate
            var memo = [Int:Bool]()
            for i in index..<nums.count {
                if memo[nums[i]] == true {
                    continue
                }
                if array.count == 0 || nums[i] >= array.last! {
                    memo[nums[i]] = true
                    helper(array:array + [nums[i]], index: i + 1)
                }
            }
        }
        
        helper(array:[Int](), index:0)
        
        return result
    }
    
    //109. Convert Sorted List to Binary Search Tree
    // The idea is to half the array everytime, find the medium as the root
    // to make the tree balance.
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        var node = head
        var nums = [Int]()
        //Convert it to array
        while node != nil {
            nums.append(node!.val)
            node = node!.next
        }
        
        if nums.count == 0 {
            return nil
        }
        
        //We use index instead of array object for conveniently check if the index is out
        //of boundary.
        func toBST(sIndex:Int, eIndex:Int) -> TreeNode? {
            guard sIndex <= eIndex, sIndex >= 0, eIndex < nums.count else {
                return nil
            }
            
            if sIndex == eIndex {
                return TreeNode(nums[sIndex])
            }
            
            let medium = (sIndex + eIndex)/2
            let node = TreeNode(nums[medium])
            node.left = toBST(sIndex:sIndex, eIndex:medium - 1)
            node.right = toBST(sIndex:medium + 1, eIndex:eIndex)
            return node
        }
        
        return toBST(sIndex:0, eIndex:nums.count - 1)
        
    }
    //938. Range Sum of BST
    // Traverse the tree inorder and get the path between L and R
    func rangeSumBST(_ root: TreeNode?, _ L: Int, _ R: Int) -> Int {
        
        var result = 0
        var shouldAdd = false
        
        func traverse(node:TreeNode?) {
            guard let n = node else {
                return
            }
            
            traverse(node:n.left)
            
            if shouldAdd {
                result += n.val
            }
            
            if n.val == L {
                result = n.val
                shouldAdd = true
            } else if n.val == R {
                shouldAdd = false
            }
            
            traverse(node:n.right)
        }
        
        traverse(node:root)
        return result
    }
    
    //611. Valid Triangle Number
    //For any triangle, longest side < small side + small side.
    //We sort the array first, then go backwards to find any low and high
    // that nums[l] + nums[h] < nums[i]. Then any num between l and h will consist
    // Triangle with nums[i]. We then lower h to exceed current h to find new candicate.
    func triangleNumber(_ nums: [Int]) -> Int {
        var nums = nums.filter{ $0 > 0 }
        guard nums.count > 2 else {
            return 0
        }
        
        var result = 0
        
        nums.sort()
        
        for i in (2..<nums.count).reversed() {
            var l = 0
            var h = i - 1
            
            while l < h {
                if nums[l] + nums[h] > nums[i] {
                    result += h - l
                    h -= 1
                } else {
                    l += 1
                }
            }
        }
        
        
        return result
    }
    
    //107. Binary Tree Level Order Traversal II
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        guard let node = root else {
            return [[Int]]()
        }
        var result = [[Int]]()
        
        func traverse(node:TreeNode?, level:Int) {
            guard let n = node else {
                return
            }
            
            if level >= result.count {
                result.append([n.val])
            } else {
                result[level] = result[level] + [n.val]
            }
            
            traverse(node:n.left, level: level + 1)
            traverse(node:n.right, level: level + 1)
        }
        
        traverse(node:node, level:0)
        return result.reversed()
    }
    
    //565. Array Nesting
    //This is tricky. Each formed loop will not be able to enter from a different num.
    //That means if you find a loop, then every element in the loop has the same max length of the circle
    // Time: O(n) n is the number of elements
    // space: O(1)
    func arrayNesting(_ nums: [Int]) -> Int {
        var result = 0
        var nums = nums
        
        for i in 0..<nums.count {
            var j = i
            var cMax = 0
            while nums[j] >= 0 {
                let num = nums[j]
                nums[j] = -1
                j = num
                cMax += 1
            }
            result = max(result, cMax)
        }
        
        return result
    }
    
    //875. Koko Eating Bananas
    //Binary search
    /*
     We get the largest possible eating time and smallest.
     Then check if the middle number is valid, if too small l = m + 1
     else h = m
     
     Time O(mlogn)
     m is the total nums of piles(we need to check if it is available m times)
     n = h - l
     
     Space O(n)
     
     
     */
    func minEatingSpeed(_ piles: [Int], _ H: Int) -> Int {
        
        var maxP = 0
        
        for p in piles {
            maxP = max(p, maxP)
        }
        
        func getEatTime(s:Int) -> Int {
            var result = 0
            for p in piles {
                if p%s == 0 {
                    result += p/s
                } else {
                    result += p/s + 1
                }
            }
            
            return result
        }
        
        var l = 1
        var h = maxP
        
        while l < h{
            let s = (l + h)/2
            if getEatTime(s:s) > H {
                l = s + 1
            } else {
                //Note here is h = s instead of h = s - 1 otherwise error will occur
                h = s
            }
        }
        
        return l
    }
    
    
    //890. Find and Replace Pattern
    //Using a memo to record the mapping between pattern and the word
    //Then a map to record which word has already been mapped
    //We invalidate a word in 2 case:
    // 1. A char in pattern that does not map to the same char in word
    // 2. A char in pattern cannot be mapped to any char but the corresponding char in word already been mapped
    // Time: O(n) n is the total characters in the words array, since we are checking for each of them.
    func findAndReplacePattern(_ words: [String], _ pattern: String) -> [String] {
        guard pattern.count > 0, words.count > 0 else {
            return [String]()
        }
        
        var result = [String]()
        var words = words.map{ $0.map({ String($0) }) }
        var pattern = pattern.map{ String($0) }
        
        for word in words {
            if word.count != pattern.count {
                continue
            }
            var memo = [String:String]()
            var mapped = [String: Bool]()
            for i in 0..<word.count {
                if let char = memo[pattern[i]] {
                    if char != word[i] {
                        break
                    }
                }  else {
                    if mapped[word[i]] == true {
                        break
                    } else {
                        //note here to record the char in word to mark it as mapped
                        memo[pattern[i]] = word[i]
                        mapped[word[i]] = true
                    }
                }
                
                if i == word.count - 1 {
                    result.append(word.joined())
                }
            }
        }
        return result
    }
    
    //518. Coin Change 2
    /*
     Important question.
     Using DP and similar to Knapsack problem
     Time O(m * n)
     space O(m * n)
     */
    func change(_ amount: Int, _ coins: [Int]) -> Int {
        var result = 0
        if amount == 0 {
            return 1
        } else if coins.count == 0 {
            return 0
        }
        //DP: the ways aount j can be made by using the coins up to coin type i
        //dp[2][5]: The ways amount 5 can be made by using coin type 1 to 2
        // coins.count + 1 instead of coins.count to cover more generic boundary
        var dp = [[Int]](repeating:[Int](repeating:0, count:amount + 1), count:coins.count + 1)
        
        for i in 0..<dp.count {
            for j in 0..<dp[0].count {
                if j == 0 {
                    dp[i][j] = 1
                } else if i == 0 {
                    dp[i][j] = 0
                }else {
                    dp[i][j] = dp[i - 1][j]
                    if j - coins[i - 1] >= 0 {
                        //Since we allow to use duplicate coins, we just look back to see
                        //How many ways current can make with amount j - coins[i - 1]
                        dp[i][j] += dp[i][j - coins[i - 1]]
                    }
                }
            }
        }
        
        return dp[coins.count][amount]
    }
    
    //628. Maximum Product of Three Numbers

    func maximumProduct(_ nums: [Int]) -> Int {
        guard nums.count > 2 else {
            return 0
        }
        
        let sNums = nums.sorted()
        var candidates = [sNums[sNums.count - 3], sNums[sNums.count - 2], sNums[sNums.count - 1]]
        return max(candidates.reduce(1, *), sNums[0] * sNums[1] * candidates[2])
    }
    
    //216. Combination Sum III
    // For num 1, we are looking for any combination between 2-9 that contains k - 1 num and total value of n - 1. Route = [1]
    //For num 2, we are looking for any combinartion between 3- 9 that contains k - 1 num and total value of n - 2. Route = [2]
    // If we take both 1 and 3, we are looking for any combination between 4 - 9 that contains k - 2 num and total value of n - 1 - 3. Route = [1, 3]
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        guard k > 0, n > 0 else {
            return [[Int]]()
        }
        
        var result = [[Int]]()
        
        func helper(index:Int, rVal:Int, cRout:[Int]) {
            if rVal == 0 && cRout.count == k  {
                result.append(cRout)
                return
            } else if index > 9 {
                return
            } else if cRout.count == k {
                return
            } else {
                for i in index...9 {
                    helper(index:i + 1, rVal:rVal - i, cRout:cRout + [i])
                }
            }
        }
        
        helper(index:1, rVal:n, cRout:[Int]())
        
        return result
    }
    
    //905. Sort Array By Parity
    func sortArrayByParity(_ A: [Int]) -> [Int] {
        var odd = [Int]()
        var even = [Int]()
        
        for num in A {
            if num % 2 == 0 {
                odd.append(num)
            } else {
                even.append(num)
            }
        }
        
        return odd + even
    }
    
    //331. Verify Preorder Serialization of a Binary Tree

    /*
     all non-null node provides 2 outdegree and 1 indegree (2 children and 1 parent), except root
     all null node provides 0 outdegree and 1 indegree (0 child and 1 parent).
     Suppose we try to build this tree. During building, we record the difference between out degree and in degree diff = outdegree - indegree. When the next node comes, we then decrease diff by 1, because the node provides an in degree. If the node is not null, we increase diff by 2, because it provides two out degrees. If a serialization is correct, diff should never be negative and diff will be zero when finished.
     */
    func isValidSerialization(_ preorder: String) -> Bool {
        var nodes = preorder.components(separatedBy:",")
        var diff = 1
        for n in nodes {
            diff -= 1
            
            if diff < 0 {
                return false
            }
            
            
            
            if n != "#" {
                diff += 2
            }
        }
        return diff == 0
    }
    
    //231. Power of Two
    func isPowerOfTwo(_ n: Int) -> Bool {
        guard n > 0 else {
            return false
        }
        
        if n == 1 {
            return true
        }
        
        if n % 2 == 0 {
            return isPowerOfTwo(n/2)
        } else {
            return false
        }
    }
    
    //270. Closest Binary Search Tree Value
    //Traverse each node and record current closest. if the target is larger than the value, then it is likely that n.right also be the result, so we traverse to that node.
    func closestValue(_ root: TreeNode?, _ target: Double) -> Int {
        guard let node = root else {
            return 0
        }
        
        var result = 0
        var minDiff = Double.greatestFiniteMagnitude
        
        
        func traverse(node: TreeNode?) {
            guard let n = node else {
                return
            }
            
            if Double(n.val) == target {
                result = n.val
                return
            } else if abs(Double(n.val) - target) <= minDiff {
                result = n.val
                minDiff = abs(Double(n.val) - target)
            }
            if target > Double(n.val) {
                traverse(node:n.right)
            } else {
                traverse(node:n.left)
            }
        }
        
        traverse(node:node)
        
        return result
    }
    
    
    //259. 3Sum Smaller
    func threeSumSmaller(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 2 else {
            return 0
        }
        
        var nums = nums.sorted()
        
        var result = 0
        for i in (2..<nums.count).reversed() {
            var h = i - 1
            var l = 0
            while l < h {
                if nums[l] + nums[h] + nums[i] < target {
                    result += h - l
                    l += 1
                } else {
                    h -= 1
                }
            }
        }
        
        return result
    }
    
    //624. Maximum Distance in Arrays
    //Be carful that the max value could comes from the same array, which invalidate the answer
    func maxDistance(_ arrays: [[Int]]) -> Int {
        var max1 = Int.min
        var max2 = Int.min
        
        var maxIndex = 0
        
        var min1 = Int.max
        var min2 = Int.max
        
        var minIndex = 0
        
        for i in 0..<arrays.count {
            if arrays[i].first! < min1 {
                min2 = min1
                min1 = arrays[i].first!
                minIndex = i
            } else if arrays[i].first! < min2 {
                min2 = arrays[i].first!
            }
            
            if arrays[i].last! > max1 {
                max2 = max1
                max1 = arrays[i].last!
                maxIndex = i
            } else if arrays[i].last! > max2 {
                max2 = arrays[i].last!
            }
        }
        
        if minIndex == maxIndex {
            return max(abs(max1 - min2), abs(max2 - min1))
        } else {
            return abs(max1 - min1)
        }
    }
    
    //304. Range Sum Query 2D - Immutable
    class NumMatrix {
        var sum = [[Int]]()
        var matrix: [[Int]]
        init(_ matrix: [[Int]]) {
            self.matrix = matrix
            self.sum = getSumMatrix(nums:matrix)
        }
        
        func getSumMatrix(nums:[[Int]]) -> [[Int]]{
            guard nums.count > 0, nums[0].count > 0 else {
                return [[Int]]()
            }
            
            var sum = [[Int]](repeating:[Int](repeating:0,count: matrix[0].count), count:matrix.count)
            
            for i in 0..<nums.count {
                for j in 0..<nums[0].count {
                    var num = nums[i][j]
                    if i - 1 >= 0 {
                        num += sum[i - 1][j]
                    }
                    
                    if j - 1 >= 0 {
                        num += sum[i][j - 1]
                    }
                    
                    if i - 1 >= 0 && j - 1 >= 0 {
                        num -= sum[i - 1][j - 1]
                    }
                    sum[i][j] = num
                }
            }
            
            print(sum)
            return sum
        }
        
        func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
            var result = sum[row2][col2]
            
            if row1 - 1 >= 0 {
                result -= sum[row1 - 1][col2]
            }
            
            if col1 - 1 >= 0 {
                result -= sum[row2][col1 - 1]
            }
            
            if col1 - 1 >= 0 && row1 - 1 >= 0 {
                result += sum[row1 - 1][col1 - 1]
            }
            
            return result
        }
    }
    
    //161. One Edit Distance
    func isOneEditDistance(_ s: String, _ t: String) -> Bool {
        guard abs(s.count - t.count) < 2 else {
            return false
        }
        
        if s.count == 0 && t.count == 0 {
            return false
        }
        
        var i = 0
        var j = 0
        var foundDiff = false
        var sArray = s.map{ String($0) }
        var tArray = t.map{ String($0) }
        
        while i < s.count && j < t.count {
            if sArray[i] != tArray[j] {
                if foundDiff {
                    return false
                }
                if s.count == t.count {
                    i += 1
                    j += 1
                } else if s.count > t.count {
                    i += 1
                } else {
                    j += 1
                }
                foundDiff = true
            } else {
                i += 1
                j += 1
            }
        }
        
        if foundDiff == false {
            if i == s.count && j == t.count {
                return false
            } else {
                return true
            }
        } else {
            return i == s.count && j == t.count
        }
    }
    
    //49. Group Anagrams
    //We use a dictionary to track the string that belongs to the same analog.
    //For each word, we sort it first, check if the sorted string match any key in the
    //dictionary, if there is already a key that match, means there is anagram. Then put word in that group
    // In the end traverse all the keys to get the group.
    // Time O(n * mlogm) m is the string length and n is the number of words in the str.
    // Space O(m)
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        guard strs.count > 0 else {
            return [[String]]()
        }
        var memo = [String: [String]]()
        
        for s in strs {
            var sortedS = String(s.sorted())
            if let strings = memo[sortedS] {
                memo[sortedS] = strings + [s]
            } else {
                memo[sortedS] = [s]
            }
        }
        
        var result = [[String]]()
        
        for key in memo.keys {
            result.append(memo[key]!)
        }
        
        return result
    }
    
    //283. Move Zeroes
    func moveZeroes(_ nums: inout [Int]) {
        guard nums.count > 0 else {
            return
        }
        
        var j = 0
        
        for i in 0..<nums.count {
            if nums[i] != 0 {
                var temp = nums[j]
                nums[j] = nums[i]
                nums[i] = temp
                j += 1
            }
        }
    }
    
    //88. Merge Sorted Array
    // Put the num to its final location instead of inserting
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = m - 1
        var j = n - 1
        
        var k = m + n - 1
        
        while i >= 0 && j >= 0 {
            if nums1[i] > nums2[j] {
                nums1[k] = nums1[i]
                k -= 1
                i -= 1
            } else {
                nums1[k] = nums2[j]
                k -= 1
                j -= 1
            }
        }
        
        
        while j >= 0 {
            nums1[k] = nums2[j]
            k -= 1
            j -= 1
        }
        
    }


    //276. Paint Fence
    /*
    For each fence with index i, assum the color is c[i]
    we have two scenario,
    c[i] != c[i - 1]
    Then we have k-1 ways to paint
    c[i] == c[i - 1]
    Then c[i - 1] must not be the same as c[i - 2]. Then we have
    k - 1 ways to paint i - 1.
    dp[i] = (k - 1) * dp[i - 1] + (k - 1) * dp[i - 2]
     */
    func numWays(_ n: Int, _ k: Int) -> Int {
        guard n > 0, k > 0 else {
            return 0
        }
        
        var dp = [Int](repeating:0, count:n + 1)
        
        for i in 0..<dp.count {
            if i == 0 {
                dp[i] = 1
            } else if i == 1 {
                dp[i] = k
            } else if i == 2 {
                dp[i] = k * k
            }   else {
                dp[i] = (k - 1) * dp[i - 1] + (k - 1) * dp[i - 2]
            }
        }
        
        return dp[n] < 0 ? 0 : dp[n]
        
    }
    
    //256. Paint House
    //In this problem, two adjacent houses canno be the same color. Since we have known type of colors, we can build dp scenario by scenario
    func minCost(_ costs: [[Int]]) -> Int {
        guard costs.count > 0 else {
            return 0
        }
        
        var dp = [[Int]](repeating:[0, 0, 0], count: costs.count)
        dp[0][0] = costs[0][0]
        dp[0][1] = costs[0][1]
        dp[0][2] = costs[0][2]
        
        
        for i in 1..<costs.count {
            dp[i][0] = min(dp[i - 1][1], dp[i - 1][2]) + costs[i][0]
            dp[i][1] = min(dp[i - 1][0], dp[i - 1][2]) + costs[i][1]
            dp[i][2] = min(dp[i - 1][0], dp[i - 1][1]) + costs[i][2]
        }
        
        let n = dp.count - 1
        
        return min(min(dp[n][0], dp[n][1]),dp[n][2])
    }
    
    //399. Evaluate Division
    /*
     This is a example of how to build a graph with weighted edges
     if a/b = 2.0, we build a graph with first edge a-2.0->b and  b-0.5->a etc.
     We store all the adjacent list in a dictionary.
     When the query comes, c/d , we perform dfs to find if there is connection between c and d, if not, then in each c's neighbor, continue search with the product of the distance
     */
    func calcEquation(_ equations: [[String]], _ values: [Double], _ queries: [[String]]) -> [Double] {
        guard equations.count > 0, values.count > 0, queries.count > 0 else {
            return [Double]()
        }
        typealias Vector = (String, Double)
        
        //Build graph
        var graph = [String: [Vector]]()
        for i in 0..<equations.count {
            let val = values[i]
            let start = equations[i][0]
            let end = equations[i][1]
            //The graph has to be bidirectional
            graph[start] = graph[start, default: [Vector]()] + [Vector(end, val)]
            graph[end] = graph[end, default: [Vector]()] + [Vector(start, 1/val)]
        }
        
        
        // we need currentVal to track the distance so far.
        // We need visited to record the visited nodes so that we do not go in loops
        func dfs(query:[String], currentVal: Double, visited:[String: Bool]) -> Double {
            let start = query[0]
            let end = query[1]
            if visited[start] == true {
                return -1.0
            }
            
            var visited = visited
            visited[start] = true
            
            guard let vectors = graph[start] else {
                return -1.0
            }
            
            for vector in vectors {
                if vector.0 == end {
                    return vector.1 * currentVal
                }
            }
            var value = -1.0
            for vector in vectors {
                let temp = dfs(query: [vector.0, end], currentVal: currentVal * vector.1, visited: visited)
                if temp != -1.0 {
                    value = temp
                }
            }
            
            return value
        }
        
        
        var result = [Double]()
        
        for query in queries {
            result.append(dfs(query: query, currentVal: 1.0, visited: [String: Bool]()))
        }
        
        return result
    }
    
    
    //698. Partition to K Equal Sum Subsets
    //We could use dfs. start from the first index, find the combination where num1 + num2 .. + num3 == target. Then start from index 0 with memory of which numbers has been used.
    func canPartitionKSubsets(_ nums: [Int], _ k: Int) -> Bool {
        if nums.count == 0 && k == 0 {
            return true
        }
        guard nums.count > 0, k > 0 else {
            return false
        }
        var target = nums.reduce(0, +)
        //Remember to check if the target can be fully divided by k
        if target % k != 0 {
            return false
        }
        target = target/k
        
        
        func canPart(index:Int, remain:Int, curSum: Int, visited:[Int: Bool]) -> Bool {
            if remain == 0 {
                return true
            }
            
            if index == nums.count {
                return false
            }
            
            if curSum == target {
                //Valid sum find, start from index 0 with all memories
                return canPart(index:0, remain:remain - 1, curSum:0, visited:visited)
            } else if curSum > target {
                return false
            }
            
            for i in index..<nums.count {
                var visited = visited
                if visited[i] == true {
                    continue
                } else {
                    visited[i] = true
                    if canPart(index:i, remain:remain, curSum: curSum + nums[i], visited: visited) {
                        return true
                    }
                }
            }
            
            return false
        }
        
        return canPart(index:0, remain:k, curSum: 0, visited:[Int: Bool]())
    }
    
    
    
    //103. Binary Tree Zigzag Level Order Traversal
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let n = root else {
            return [[Int]]()
        }
        
        var result = [[Int]]()
        var memo = [Int: [Int]]()
        
        func traverse(root: TreeNode?, level: Int) {
            guard let node = root else {
                return
            }
            
            if let nodes = memo[level] {
                if  level % 2 == 1 {
                    memo[level] = [node.val] + nodes
                } else {
                    memo[level] = nodes + [node.val]
                }
            } else {
                memo[level] = [node.val]
            }
            
            traverse(root:node.left, level: level + 1)
            traverse(root:node.right, level: level + 1)
        }
        
        traverse(root:n, level:0)
        for i in 0..<memo.keys.count {
            result.append(memo[i]!)
        }
        
        return result
    }
    
    //266. Palindrome Permutation

    func canPermutePalindrome(_ s: String) -> Bool {
        guard s.count > 0 else {
            return false
        }
        
        var memo = [String:Int]()
        
        var sArray = s.map{ String($0) }
        for char in sArray {
            memo[char] = memo[char, default:0] + 1
        }
        
        var found = false
        
        for key in memo.keys {
            if memo[key]! % 2 != 0 {
                if found {
                    return false
                } else {
                    found = true
                }
            }
        }
        
        return true
    }
    
    
    /*
     This is basically detect if there is loop in the built graph. One important message is that the number of course to finish is equal to the total number of course. That means if there is no loop the course is gareenteed to be finished. Then we build the graph, go through each of the course do dfs.
     Note we have to keep track of two sets of memo. One is the node we visited so far to ensure we did not traverse again. One is the node visited for current dfs. If a node is found again a circle is detected.
     Time: O(N) N is the number of course.
     Space: O(N * N)
     
     */
    
    //207. Course Schedule
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        guard numCourses > 0 else {
            return true
        }
        guard prerequisites.count > 0 else {
            return true
        }
        
        var target = numCourses
        var graph = [Int:[Int]]()
        
        for p in prerequisites {
            graph[p[0]] = graph[p[0], default:[Int]()] + [p[1]]
        }
        
        var visited = [Int: Bool]()
        
        func dfs(node: Int, curVisited:[Int: Bool]) -> Bool {
            guard curVisited[node] == nil else {
                return false
            }
            guard visited[node] == nil else {
                return true
            }
            visited[node] = true
            var curVisited = curVisited
            curVisited[node] = true
            guard let neighbors = graph[node] else  {
                return true
            }
            for n in neighbors {
                if dfs(node:n, curVisited:curVisited) == false {
                    return false
                }
            }
            return true
        }
        for i in 0..<numCourses {
            if !dfs(node: i, curVisited: [Int:Bool]()) {
                return false
            }
        }
        return true
    }
    
    // 210. Course Schedule II
    /*
     The difference between 210. Course Schedule II and 207. Course Schedule is that we need to print out the result not only detect if loop exists. In this case we need to do the same thing as Course Schedule I. However, we need to dps with post order, meaning that we need to visit all the prerequisites of the node (e.g. all node connected to current node) then visit node itself when the prerequisite is finished.
     Samilarly, we keep track of current visited node and the node visited in current dfs. If a visited node appears then a loop if detected.
     Note tha we always ask the dfs function to return false if a loop is detected and true if the taverse is compeleted successfully.
     Time: O(n) since we only visit each node once
     Space: O(n) graph
     */
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        guard numCourses > 0 else {
            return [Int]()
        }
        
        var result = [Int]()
        var graph = [Int: [Int]]()
        
        for p in prerequisites {
            graph[p[0]] = graph[p[0], default:[Int]()] + [p[1]]
        }
        
        var memo = [Int: Bool]()
        
        func dfs(index:Int, path:[Int:Bool]) -> Bool {
            if path[index] == true {
                return false
            }
            
            if memo[index] == true {
                return true
            }
            var path = path
            //We need to set the path to true whenever we go through a node.
            // If we do it after dfs takes action then it is too late as loop is already created
            path[index] = true
            
            if let neighb = graph[index] {
                for ne in neighb {
                    if !dfs(index:ne, path: path) {
                        return false
                    }
                }
            }
            
            result.append(index)
            memo[index] = true
            return true
        }
        
        for i in 0..<numCourses {
            if !dfs(index:i, path:[Int:Bool]()) {
                return [Int]()
            }
        }
        
        return result
        
    }
    
    //329. Longest Increasing Path in a Matrix
    /*
     This is a special case of dfs.
     The original way to dfs in 2d matrix is to traverse the array with a memory of what node has been visited, find the node that matches the scenario while keep recording of current max/min value.
     However it no longer simply works in this case. In this case, the definition of what node should be included in dfs consist of 2 scenario. The next num is smaller than current number  or larger than current number. If we do dfs will miss another scenario.
     So we use memo[i][j] means longest length that at matrix[i][j] can archive.
     */
    func longestIncreasingPath(_ matrix: [[Int]]) -> Int {
        guard matrix.count > 0 && matrix[0].count > 0 else {
            return 0
        }
        
        var memo = [[Int]](repeating:[Int](repeating:0, count:matrix[0].count), count:matrix.count)
        
        var result = 1
        
        let coodinate = [[1, 0], [0, 1], [-1, 0], [0, -1]]
        
        func dfs(r:Int, c:Int) -> Int {
            if memo[r][c] != 0 {
                return memo[r][c]
            }
            
            var count = 1
            
            for co in coodinate {
                var newR = r + co[0]
                var newC = c + co[1]
                
                if newR < 0 || newC < 0 || newR >= memo.count || newC >= memo[0].count || matrix[newR][newC] <= matrix[r][c] {
                    continue
                }
                
                let len = 1 + dfs(r:newR, c:newC)
                count = max(count, len)
            }
            
            memo[r][c] = count
            return count
        }
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[0].count {
                var count = dfs(r:i, c:j)
                result = max(count, result)
            }
        }
        
        return result
    }
    
    
    //40. Combination Sum II
    /*
     Sort the array to avoid duplicate
     Traverse each element in the array, if the element is the same as the previous element, then do not traverse. Otherwise continue to find the value - num[i]
     Time = n + n - 1 + .. + 1 = O(n^2)
     Space = O(n ^ 2) (for the result)
     
     */
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        guard candidates.count > 0, target > 0 else {
            return [[Int]]()
        }
        
        var result = [[Int]]()
        var nums = candidates.sorted()
        
        func traverse(index:Int, t: Int, path:[Int]) {
            if t == 0 {
                result.append(path)
                return
            } else if t < 0 || index > nums.count {
                return
            }
            
            for i in index..<nums.count {
                if i > index && nums[i] == nums[i - 1] {
                    continue
                }
                
                traverse(index: i + 1, t: t - nums[i], path:path + [nums[i]])
            }
        }
        
        traverse(index:0, t: target, path:[Int]())
        return result
    }
    
    //377. Combination Sum IV

    /*
     This is different from sum III/II/I as it only requires the numbers of the
     combination instead of combination itself.
     In this case we can simplify the algorithm we use and use dp instead.
     dp[n]: number of ways to sum to n with input nums.
     dp[n] = dp[n - nums[0]] + dp[n - nums[1]] + ... + dp[n - nums[n]]
     
     Time Complexity: O(t * nums.count)
     space Complexity: O(t)
     */
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0, target > 0 else {
            return 0
        }
        
        //We use double here becuase it exceed Int.max
        var dp = [Double](repeating:Double(0), count: target + 1)
        
        dp[0] = 1
        
        for i in 1...target {
            for j in 0..<nums.count {
                if i - nums[j] >= 0 {
                    dp[i] += dp[i - nums[j]]
                }
            }
        }
        
        return Int(dp[target])
    }
    
    
    /* we precalculate the sum up to current array. then check if there is prvious sum pSum that sum - k = pSum. If so plus the frequncy of that sum*/
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        if nums.count == 0 && k == 0 {
            return 1
        }
        
        guard nums.count > 0 else {
            return 0
        }
        var sum = 0
        var result = 0
        var memo = [Int: Int]()
        
        memo[0] = 1
        for i in 0..<nums.count {
            sum += nums[i]
            if let count = memo[sum - k] {
                result += count
            }
            
            memo[sum] = memo[sum, default:0] + 1
        }
        
        return result
    }
    
    
    //904. Fruit Into Baskets
    //Brute force. Go through each tree and use it as start point. See how many trees we can traverse before we stop.
    //Time O(n^2) as in worsest case each element is valid candidate
    //space O(n)
    func totalFruitBF(_ tree: [Int]) -> Int {
        guard tree.count > 0 else {
            return 0
        }
        
        var result = Int.min
        
        func pick(index: Int) {
            var basket = [Int]()
            var filled = false
            for i in index..<tree.count {
                if !basket.contains(tree[i]) {
                    if basket.count < 2 {
                        basket.append(tree[i])
                    } else {
                        result = max(result, i - index)
                        filled = true
                        break
                    }
                }
            }
            
            //The basket did not hit the stop condition
            if !filled {
                result = max(result, tree.count - index)
            }
        }
        
        for i in 0..<tree.count {
            pick(index:i)
        }
        
        return result
    }
    
    /*
     Sliding window. We keep track of the frequence of the element in the window. If a new element apears, we shrink the window until the new window only has two types of elements. In order to do that, move i to right and delete the element met in the dictionary until the window is valid again.
     Time: O(n)
     Space: O(n)
     */
    func totalFruit(_ tree: [Int]) -> Int {
        guard tree.count > 0 else {
            return 0
        }
        
        var result = Int.min
        var i = 0
        var j = 0
        //We need to use dictionary to track the frequency of current element
        //When i is moving right, we know delete the met element from dictionary until only 2 element is in that dictionary.
        var basket = [Int:Int]()
        
        while j < tree.count {
            if !basket.keys.contains(tree[j]) {
                if basket.count < 2 {
                    basket[tree[j]] = 1
                } else {
                    basket[tree[j]] = 1
                    //make the window valid again
                    while basket.keys.count > 2 {
                        if let count = basket[tree[i]] {
                            if count - 1 == 0 {
                                basket[tree[i]] = nil
                            } else {
                                basket[tree[i]] = count - 1
                            }
                        }
                        i += 1
                    }
                }
            } else {
                basket[tree[j]] = basket[tree[j], default:0] + 1
            }
            result = max(result, j - i + 1)
            j += 1
        }
        
        
        return result
    }
    
    //929. Unique Email Addresses

    func numUniqueEmails(_ emails: [String]) -> Int {
        guard emails.count > 0 else {
            return 0
        }
        
        var memo = [String:Bool]()
        
        func getValidEmail(email: String) {
            var components = email.components(separatedBy:"@")
            if components.count != 2 {
                return
            }
            var localName = components[0].map{ String($0) }
            var domainName = components[1]
            
            var newLocal = [String]()
            for char in localName {
                if char == "+" {
                    break
                } else if char == "." {
                    continue
                }
                newLocal.append(char)
            }
            
            var localString = newLocal.joined() + "@" + domainName
            memo[localString] = true
        }
        
        for email in emails {
            getValidEmail(email:email)
        }
        
        return memo.keys.count
    }
    
    //36. Valid Sudoku
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        guard board.count == 9, board[0].count == 9 else {
            return false
        }
        var rows = [[Character:Bool]](repeating:[Character:Bool](),count:9)
        var cols = [[Character:Bool]](repeating:[Character:Bool](),count:9)
        var squares = [[[Character:Bool]]](repeating:[[Character:Bool]](repeating:[Character:Bool](),count:3),count:3)
        
        for i in 0..<board.count {
            for j in 0..<board[0].count {
                var cell = board[i][j]
                if cell == "." {
                    continue
                }
                var sRow = i/3
                var sCol = j/3
                if  rows[i][cell] == true || cols[j][cell] == true || squares[sRow][sCol][cell] == true {
                    return false
                }
                
                cols[j][cell] = true
                rows[i][cell] = true
                squares[sRow][sCol][cell] = true
            }
        }
        return true
    }
    
    
    //45. Jump Game II
    func jump(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        
        var result = 0
        
        var index = 0
        while index < nums.count - 1 {
            result += 1
            let range = index + nums[index]
            if range >= nums.count - 1 {
                break
            }
            var nIndex = index
            for i in index...range {
                if nums[i] + i > nums[nIndex] + nIndex {
                    nIndex = i
                }
            }
            
            if nIndex + nums[nIndex] <= range {
                result = 0
                break
            }
            
            index = nIndex
        }
        
        return result
    }
    //1. Two Sum

    /*
     Should be easy but we need to ask a few questions.
     Do we have multiple answers?
     Can we use the same element twice?
     Is there any duplicates in the array?
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        guard nums.count > 0 else {
            return [Int]()
        }
        
        var result = [Int]()
        
        var dict = [Int: Int]()
        for i in 0..<nums.count {
            if let index = dict[nums[i]] {
                //This is important to avoid using the same element twice
                if i != index {
                    result = [i, index]
                    break
                }
            }
            dict[target - nums[i]] = i
        }
        
        return result
    }
    
    //785. Is Graph Bipartite?
    /*
     Paint the node into two colors with dfs, each node should be different from its parent node If a node is painted alreay and the color is the same as its parent, then return false. If the whole graph is painted successfully. Return true.
     */
    func isBipartite(_ graph: [[Int]]) -> Bool {
        guard graph.count > 0 else {
            return false
        }
        let black = 0
        let white = 1
        var visited = [Int:Int]()
        
        func bfs(node:Int, pColor:Int) -> Bool {
            if let color = visited[node] {
                return color != pColor
            }
            
            visited[node] = pColor == white ? black : white
            
            let neighb = graph[node]
            for n in neighb {
                if !bfs(node:n, pColor:visited[node]!) {
                    return false
                }
            }
            return true
        }
        
        //Note here we need to loop through all the nodes just in case we have
        //isolated node
        for i in 0..<graph.count {
            if visited[i] == nil {
                if !bfs(node:i, pColor:white) {
                    return false
                }
            }
        }
        
        return true
    }
    
    
    //261. Graph Valid Tree

    
    /*
     How to determin is a bidirectional graph has circles:
     Keep track of an reference to the previous visited node. If the current node's
     neighb has previous node, skip it, as it is expected. however if current node has
     a node that is already visited, then a loop is detected
     */
    func validTree(_ n: Int, _ edges: [[Int]]) -> Bool {
        guard edges.count > 0 else {
            //Special case here. single node tree
            return n == 1
        }
        
        var graph = [Int:[Int]]()
        for e in edges {
            if e[0] == e[1] {
                return false
            }
            
            graph[e[0]] = graph[e[0], default:[Int]()] + [e[1]]
            graph[e[1]] = graph[e[1], default:[Int]()] + [e[0]]
        }
        var visited = [Int:Bool]()
        
        func dfs(n:Int, parent:Int) -> Bool {
            guard let neighbs = graph[n] else {
                return false
            }
            
            visited[n] = true
            
            for ne in neighbs {
                if ne == parent {
                    continue
                }
                
                if visited[ne] == true {
                    return false
                }
                if !dfs(n:ne, parent:n) {
                    return false
                }
            }
            
            return true
        }
        if !dfs(n:0, parent:-1) {
            return false
        }
        
        return visited.keys.count == n
    }
    
    //417. Pacific Atlantic Water Flow

    /*
     DFS from the side to the middle.
     Do the boundary check at the begining of the dfs function instead of during the loop.
     Do not think to do two things at one dfs. Seperate them. It does not change Big O
     */
    func pacificAtlantic(_ matrix: [[Int]]) -> [[Int]] {
        guard matrix.count > 0, matrix[0].count > 0 else {
            return [[Int]]()
        }
        
        var result = [[Int]]()
        
        //-1: Node is not visited
        // 0: Node does not lead to ocean
        // 1: Node lead to ocean.
        var memoA = [[Bool]](repeating:[Bool](repeating:false, count:matrix[0].count), count: matrix.count)
        var memoP = [[Bool]](repeating:[Bool](repeating:false, count:matrix[0].count), count: matrix.count)
        let dirs = [[1, 0], [0, 1], [-1, 0], [0, -1]]
        
        func dfs(i:Int, j:Int, height:Int, isA: Bool) {
            if i < 0 || j < 0 || i >= matrix.count || j >= matrix[0].count || matrix[i][j] < height {
                return
            }
            
            if isA && memoA[i][j] == true {
                return
            }
            
            if !isA && memoP[i][j] == true {
                return
            }
            
            if isA {
                memoA[i][j] = true
            } else {
                memoP[i][j] = true
            }
            
            for dir in dirs {
                dfs(i: i + dir[0], j: j + dir[1], height: matrix[i][j], isA: isA)
            }
        }
        
        for m in 0..<matrix[0].count {
            dfs(i: 0, j: m, height: Int.min, isA: false)
            dfs(i: matrix.count - 1, j: m, height: Int.min, isA: true)
        }
        
        for n in 0..<matrix.count {
            dfs(i: n, j: 0, height: Int.min, isA: false)
            dfs(i: n, j: matrix[0].count - 1, height: Int.min, isA: true)
        }
        
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[0].count {
                if memoP[i][j] == true && memoA[i][j] == true {
                    result.append([i, j])
                }
            }
        }
        
        
        return result
    }
    
    
    // 380. Insert Delete GetRandom O(1)
    class RandomizedSet {
        var store: [Int:Int]
        var nums: [Int]
        /** Initialize your data structure here. */
        init() {
            store = [Int:Int]()
            nums = [Int]()
        }
        
        /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
        func insert(_ val: Int) -> Bool {
            if store[val] != nil {
                return false
            }
            store[val] = nums.count
            nums.append(val)
            return true
        }
        
        /** Removes a value from the set. Returns true if the set contained the specified element. */
        func remove(_ val: Int) -> Bool {
            guard let loc = store[val] else {
                return false
            }
            
            if loc < nums.count - 1 {
                nums.swapAt(loc,nums.count - 1)
            }
            store[nums[loc]] = loc
            store[val] = nil
            nums.removeLast()
            
            return true
        }
        
        /** Get a random element from the set. */
        func getRandom() -> Int {
            if nums.count == 0 {
                return 0
            }
            let ran = Int.random(in:0..<nums.count)
            return nums[ran]
        }
    }

    //73. Set Matrix Zeroes
    func setZeroes(_ matrix: inout [[Int]]) {
        guard matrix.count > 0, matrix[0].count > 0 else {
            return
        }
        
        var colMemo = [Int:Bool]()
        var rowMemo = [Int:Bool]()
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                if matrix[i][j] == 0 {
                    rowMemo[i] = true
                    colMemo[j] = true
                }
            }
        }
        
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                if rowMemo[i] == true || colMemo[j] == true {
                    matrix[i][j] = 0
                }
            }
        }
        
    }
    
    //204. Count Primes
    func countPrimes(_ n: Int) -> Int {
        guard n > 2 else {
            return 0
        }
        
        var count = 0
        var notPrime = [Int:Bool]()
        
        for i in 2..<n {
            if notPrime[i] == nil {
                count += 1
                var j = 2
                while j * i < n {
                    notPrime[j * i] = true
                    j += 1
                }
            }
        }
        return count
    }
    
    //403. Frog Jump
    func canCross(_ stones: [Int]) -> Bool {
        //[0,{1},{3},{5},6,{8},{12}, {17}]
        //    1   2   2     3   4     5
        
        //backtracing
        //check if it is the last stone, if it is return true
        //have current index i and pre steps s
        //check if stones[i] + [s - 1, s + 1] lands any later stone
        //for all the landed stone
        //backtrace newIndex, new steps
        //If no stone available return false
        
        guard stones.count > 1 else {
            return true
        }
        
        var memo = [Int: Int]()
        
        for i in 0..<stones.count {
            if i > 3 && stones[i] > stones[i - 1] * 2 {
                return false
            }
            memo[stones[i]] = i
        }
        
        var deadEnd = [[Bool]](repeating:[Bool](repeating:false, count:stones.count + 1), count: stones.count + 1)
        
        
        
        func jump(index:Int, preStep:Int) -> Bool {
            if index == stones.count - 1 {
                return true
            }
            
            if deadEnd[index][preStep] == true {
                return false
            }
            
            if let nIndex = memo[stones[index] + preStep - 1], nIndex > index{
                if jump(index:nIndex ,preStep:preStep - 1) {
                    return true
                } else {
                    deadEnd[nIndex][preStep - 1] = true
                }
            }
            
            if let nIndex = memo[stones[index] + preStep], nIndex > index {
                if jump(index:nIndex,preStep:preStep) {
                    return true
                } else {
                    deadEnd[nIndex][preStep] = true
                }
            }
            
            if let nIndex = memo[stones[index] + preStep + 1], nIndex > index {
                if jump(index:nIndex,preStep:preStep + 1) {
                    return true
                } else {
                    deadEnd[nIndex][preStep + 1] = true
                }
            }
            
            return false
        }
        
        return jump(index:0, preStep: 0)
    }
    
    //297. Serialize and Deserialize Binary Tree

    func serialize(node: TreeNode?) -> String {
        var stack = [String]()
        
        func traverse(node: TreeNode?) {
            guard let n = node else {
                stack.append("*")
                return
            }
            
            stack.append(String(n.val))
            traverse(node: n.left)
            traverse(node: n.right)
        }
        
        traverse(node: node)
        return stack.joined()
    }
    
    
    func deserialize(string:String) -> TreeNode? {
        var queue = string.map({ String($0) })
        
        func buildTree() -> TreeNode? {
            if queue.count == 0 {
                return nil
            }
            
            let val = queue.removeFirst()
            if val == "*" {
                return nil
            }
            
            let node = TreeNode(Int(val)!)
            node.left = buildTree()
            node.right = buildTree()
            return node
        }
        
        return buildTree()
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

//iteratively solution
func knapsack(weights:[Int], values:[Int], w:Int) -> Int {
    guard weights.count > 0, values.count > 0, w > 0 else {
        return 0
    }
    
    //dp: the maxium value can be archived using first ith item and not exceeding j
    //dp[i][j] = max(dp[i - 1][j], dp[i][j - weights[i]] + values[i])
    var dp = [[Int]](repeating: [Int](repeating: 0, count: w + 1), count: weights.count + 1)
    
    for i in 0..<dp.count {
        for j in 0..<dp[0].count {
            if i == 0 || j == 0 {
                dp[i][j] = 0
            } else {
                if j - weights[i - 1] >= 0 {
                    //Note here using dp[i - 1] instead of dp[i] to avoid using the same item again.
                    dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - weights[i - 1]] + values[i - 1])
                } else {
                    dp[i][j] = dp[i - 1][j]
                }
            }
        }
    }
    return dp[weights.count][w]
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

// DFS for with a adjcent matrix

var test =
    [[0, 1, 0, 0, 1, 1, 0, 0],
     [1, 0, 0, 0, 0, 1, 1, 0],
     [0, 0, 0, 1, 0, 0, 1, 0],
     [0, 0, 1, 0, 0, 0, 0, 1],
     [1, 0, 0, 0, 0, 1, 0, 0],
     [1, 1, 0, 0, 1, 0, 0, 0],
     [0, 1, 1, 0, 0, 0, 0, 1],
     [0, 0, 0, 1, 0, 0, 1, 0]]


var visited = Array(repeating: false, count: test.count)

func dfsGraph(adjMatrix:[[Int]], size: Int, i: Int) {
    //This column should be marked as visited
    print("visiting \(i) ")
    visited[i] = true
    for j in 0..<size {
        if !visited[j] && adjMatrix[i][j] == 1 {
            //If some index in that column is unvisited, we jump to visit that column.
            dfsGraph(adjMatrix: adjMatrix, size: size, i: j)
        }
    }
}

dfsGraph(adjMatrix: test, size: visited.count, i: 0)


public class Interval {
    public var start: Int
    public var end: Int
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}




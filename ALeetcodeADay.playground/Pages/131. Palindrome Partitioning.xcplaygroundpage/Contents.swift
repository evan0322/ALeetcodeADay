//: [Previous](@previous)

import Foundation


//131. Palindrome Partitioning

/*
 Backtracing problem. we first build a dp that can check if in string s, s[i...j] is parlindrome. Then we do dfs. for each sub string with index i in index..<s.count, if dp[index][i] is a parlindrome, we keep searching with new index i + 1. until we reach the last char in s
 
 Time: O(n^2) n is the length of s
 Space: O(n^2) n is the length of s
 */
func partition(_ s: String) -> [[String]] {
    guard s.count > 0 else {
        return [[String]]()
    }
    
    var s = s.map{ String($0) }
    var result = [[String]]()
    
    var dp = [[Bool]](repeating:[Bool](repeating:false, count:s.count), count:s.count)
    
    for j in 0..<s.count {
        for i in (0...j).reversed() {
            dp[i][j] = s[i] == s[j] && (j - i < 2 || dp[i + 1][j - 1])
        }
    }
    
    func dfs(index:Int, path:[String]) {
        if index >= s.count {
            result.append(path)
        }
        
        for i in index..<s.count {
            if dp[index][i] {
                dfs(index: i + 1, path: path + [Array(s[index...i]).joined()])
            }
        }
    }
    
    dfs(index: 0, path: [String]())
    return result
}

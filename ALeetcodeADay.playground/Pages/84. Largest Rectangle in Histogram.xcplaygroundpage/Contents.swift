
import Foundation


//84. Largest Rectangle in Histogram
class Solution {
    //Use dynamic programming
    //     func largestRectangleArea(_ heights: [Int]) -> Int {
    //         guard heights.count > 0 else {
    //             return 0
    //         }
    
    //         if heights.count == 1 {
    //             return heights[0]
    //         }
    
    //         var result = 0
    
    //         //DP[i][j] smallest element from index i to j
    //         //Then dp[i][j] = min(min(dp[i + 1][j], heights[i]), min(dp[i][j - 1], heights[j]))
    //         var dp = Array(repeating:Array(repeating:-1, count:heights.count), count: heights.count)
    
    
    //         for j in 0..<heights.count {
    //             for i in (0...j).reversed() {
    //                 if i == j {
    //                     dp[i][j] = heights[i]
    //                 } else {
    //                     dp[i][j] = min(min(dp[i + 1][j], heights[i]), min(dp[i][j - 1], heights[j]))
    //                 }
    //                 result = max(result, dp[i][j] * (j - i + 1))
    //             }
    //         }
    //         return result
    //     }
    
    //stack solution
    /*
     For the problem of the graph with a bar, we need to first think what the problem can be translated to. For example, in this problem, we can translate this to: for each bar, find the max rectagle can be formed with current bar as the smallest. Then we can further translate the problem to: for each bar i, find the first bar that smaller thant current bar on the left, and find the first bar that are smaller than current bar on the right, then area = (right - left - 1) * height[i]. So we keep a stack of bars, if we have h[i] < stack.last, then the first bar on the right that small er than i has been found, apparently the left boundary is next item in the stack as the bar is in ascending order. If the stack is empty, then that means thers is no previous bar that lower than stack.last, then we have width of i, otherwise width = i - stack.last - 1.
     */
    func largestRectangleArea(_ heights: [Int]) -> Int {
        guard heights.count > 0 else {
            return 0
        }
        
        let heights = [0] + heights + [0]
        
        var stack = [Int]()
        var mh = 0
        
        for i in 0..<heights.count {
            while stack.count > 0 && heights[stack.last!] > heights[i] {
                let cur = stack.removeLast()
                let width = i - stack.last! - 1
                mh = max(width * heights[cur], mh)
            }
            stack.append(i)
        }
        
        return mh
}

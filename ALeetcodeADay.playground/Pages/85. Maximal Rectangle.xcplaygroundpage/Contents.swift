//: [Previous](@previous)

import Foundation

//85. Maximal Rectangle
/*
 We use similar proach as  84. Largest Rectangle in Histogram. Now we calculater the max rectangle for each row.
 Time complexity O(m * n)
 Space O(m * n)
 */
func maximalRectangle(_ matrix: [[Character]]) -> Int {
    guard matrix.count > 0, matrix[0].count > 0 else {
        return 0
    }
    
    var heights = [[Int]](repeating:[Int](repeating:0, count: matrix[0].count + 2), count:matrix.count)
    
    var result = 0
    
    for i in 0..<matrix.count {
        var stack = [Int]()
        var chars = ["0"] + matrix[i] + ["0"]
        for m in 0..<chars.count {
            if chars[m] == "0" {
                heights[i][m] = 0
            } else {
                heights[i][m] = (i == 0 ? 1 : heights[i - 1][m] + 1)
            }
            
            while stack.count > 0 && heights[i][stack.last!] > heights[i][m] {
                let cur = stack.removeLast()
                let width = m - stack.last! - 1
                result = max(result, heights[i][cur] * width)
            }
            stack.append(m)
        }
    }
    
    return result
}

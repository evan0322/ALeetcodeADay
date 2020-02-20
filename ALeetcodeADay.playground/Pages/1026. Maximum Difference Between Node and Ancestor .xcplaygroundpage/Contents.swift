//: [Previous](@previous)

import Foundation
/*
For each node n, find the largest and smallest value of direct or undirect child node.
*/
func maxAncestorDiff(_ root: TreeNode?) -> Int {
    guard let node = root else {
        return 0
    }
    
    dfs(node)
    
    return maxDiff
}


func dfs(_ root:TreeNode?) -> [Int] {
    guard let node = root else {
        return [Int]()
    }
    
    let left = dfs(node.left)
    let right = dfs(node.right)
    var minVal = node.val
    var maxVal = node.val
    
    if left.count > 0 {
        minVal = min(left[0],minVal)
        maxVal = max(left[1],maxVal)
    }
    
    if right.count > 0 {
        minVal = min(right[0],minVal)
        maxVal = max(right[1],maxVal)
    }
    
    maxDiff = max(maxDiff, max(abs(node.val - minVal), abs(node.val - maxVal)))
    
    return [minVal, maxVal]
}

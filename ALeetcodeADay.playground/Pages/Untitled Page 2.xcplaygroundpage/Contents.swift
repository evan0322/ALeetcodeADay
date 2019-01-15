//: [Previous](@previous)

import Foundation

/*
 We reset the count after we find an invalid subsequnce.
 */

//298. Binary Tree Longest Consecutive Sequence

func longestConsecutive(_ root: TreeNode?) -> Int {
    guard let node = root else {
        return 0
    }
    
    var result = 0
    
    func traverse(root:TreeNode?, target:Int, count:Int) {
        guard let node = root else {
            result = max(count,result)
            return
        }
        var count = count
        if node.val != target {
            result = max(count,result)
            count = 1
        } else {
            count += 1
        }
        
        
        traverse(root:node.left, target: node.val + 1, count: count)
        traverse(root:node.right, target: node.val + 1, count:count)
    }
    
    
    traverse(root:node, target:node.val, count: 0)
    return result
}

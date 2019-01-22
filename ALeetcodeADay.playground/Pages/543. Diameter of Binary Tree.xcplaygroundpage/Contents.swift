//: [Previous](@previous)

import Foundation

/*
Samilar to any problem that involve traverse from left to right leaf (cross the node).
 
 The traverse function has two responsisbility: Calculate the current value, and provide a value for the previous caller to calculate. In this case, the function has to provide the max path from its left or right node down, also it needs to calculate the current max.
 */
func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
    guard let node = root else {
        return 0
    }
    
    var result = 0
    
    func traverse(root:TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        
        let left = traverse(root:node.left)
        let right = traverse(root:node.right)
        
        result = max(result, 1 + left + right)
        
        return 1 + max(left, right)
    }
    
    traverse(root:node)
    
    return result - 1
}

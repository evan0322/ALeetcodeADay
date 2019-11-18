//: [Previous](@previous)

import Foundation

//958. Check Completeness of a Binary Tree
//DFS the tree until a nil node is reached. If after the nil node there is no node, then it is a complete binary tree.

func isCompleteTree(_ root: TreeNode?) -> Bool {
    var queue = [TreeNode?]()
    queue.append(root)
    var nilFound = false
    
    while queue.count > 0 {
        let node = queue.removeFirst()
        if node == nil {
            nilFound = true
        } else {
            if nilFound {
                return false
            } else {
                queue.append(node!.left)
                queue.append(node!.right)
            }
        }
    }
    return true
}

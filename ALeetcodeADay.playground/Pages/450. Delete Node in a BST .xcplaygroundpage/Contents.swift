//: [Previous](@previous)

import Foundation


//1. Find the target
//2. Find the min node on its right
//3. Swap the value of the min node with target node
//4. Remove the min node
func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
    guard let node = root else {
        return nil
    }
    
    if key > node.val {
        node.right = deleteNode(node.right, key)
    } else if key < node.val {
        node.left = deleteNode(node.left, key)
    } else {
        if node.left == nil && node.right == nil {
            return nil
        } else if node.left == nil {
            return node.right
        } else if node.right == nil {
            return node.left
        }
        
        let minNode = findMinNode(root:node.right!)
        node.val = minNode.val
        node.right = deleteNode(node.right!, node.val)
    }
    return root
}

func findMinNode(root:TreeNode) -> TreeNode {
    var cNode = root
    
    while cNode.left != nil {
        cNode = cNode.left!
    }
    return cNode
}

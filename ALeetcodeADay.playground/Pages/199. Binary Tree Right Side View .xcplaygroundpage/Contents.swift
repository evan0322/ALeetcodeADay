//: [Previous](@previous)

import Foundation

func rightSideView(_ root: TreeNode?) -> [Int] {
    guard let root = root else {
        return [Int]()
    }
    
    var result = [Int]()
    
    func traverse(_ node:TreeNode? , _ depth:Int) {
        guard let node = node else {
            return
        }
        
        if depth > result.count {
            result.append(node.val)
        } else {
            result[depth - 1] = node.val
        }
        
        traverse(node.left,depth + 1)
        traverse(node.right,depth + 1)
    }
    
    traverse(root,1)
    
    return result
}

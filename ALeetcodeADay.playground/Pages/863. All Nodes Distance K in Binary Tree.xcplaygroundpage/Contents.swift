//: [Previous](@previous)

import Foundation

var pRoot = PTreeNode(0)
var pTarget = PTreeNode(0)

func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ K: Int) -> [Int] {
    guard let root = root, let target = target else {
        return [Int]()
    }
    
    
    func traverse(_ node:TreeNode?) -> PTreeNode? {
        guard let node = node else {
            return nil
        }
        
        let pNode = PTreeNode(node.val)
        pNode.left = traverse(node.left)
        pNode.right = traverse(node.right)
        pNode.left?.parent = pNode
        pNode.right?.parent = pNode
        
        if node === target {
            pTarget = pNode
        }
        
        return pNode
    }
    
    pRoot = traverse(root)!
    var dis = 0
    var result = [Int]()
    
    func dfs(_ node:PTreeNode?, _ pre:PTreeNode, _ dis:Int) {
        guard let node = node else {
            return
        }
        
        if dis == K {
            result.append(node.val)
            return
        }
        
        if let parent = node.parent, parent !== pre {
            dfs(parent, node,dis + 1)
        }
        
        if let left = node.left, left !== pre {
            dfs(left, node,dis + 1)
        }
        
        if let right = node.right , right !== pre {
            dfs(right, node, dis + 1)
        }
    }
    
    dfs(pTarget, PTreeNode(0), 0)
    
    return result
}

class PTreeNode {
    public var val:Int
    public var left: PTreeNode?
    public var right: PTreeNode?
    public var parent: PTreeNode?
    public init(_ val:Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.parent = nil
    }
}

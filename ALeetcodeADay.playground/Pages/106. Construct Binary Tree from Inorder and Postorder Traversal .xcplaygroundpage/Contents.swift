//: [Previous](@previous)

import Foundation

//The root of current tree is always the last element in the post order traversal tree
func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
    guard inorder.count > 0 && postorder.count > 0 && inorder.count == postorder.count else {
        return nil
    }
    
    var postorder = postorder
    
    //record the index of the inorder tree. Note: no duplicates
    var memo = [Int:Int]()
    
    for (i, value) in inorder.enumerated() {
        memo[value] = i
    }
    
    func buildTreeFrom(start:Int, end:Int) -> TreeNode? {
        if start > end || postorder.count == 0 {
            return nil
        }

        let value = postorder.removeLast()
        let root = TreeNode(value)
        let index = memo[value]!

        root.right = buildTreeFrom(start:index + 1, end:end)
        root.left = buildTreeFrom(start:start, end:index - 1)

        return root
    }
    
    return buildTreeFrom(start:0, end:inorder.count - 1)
    
}

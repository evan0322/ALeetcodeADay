//: [Previous](@previous)

import Foundation

func maxPathSum(_ root: TreeNode?) -> Int {
    var result = Int.min
    
    //max down returns the max value that node can provide as an branch node (not the root node)
    func maxDown(_ node: TreeNode?) -> Int {
        guard let n = node else {
            return 0
        }
        
        let maxLeft = max(maxDown(n.left), 0)
        let maxRight = max(maxDown(n.right), 0)
        //Sometimes the result may not be returned, instead it will be calculated during the execution
        result = max(result, maxLeft + maxRight + n.val)
        return n.val + max(maxLeft, maxRight)
    }
    
    maxDown(root)
    
    return result
}

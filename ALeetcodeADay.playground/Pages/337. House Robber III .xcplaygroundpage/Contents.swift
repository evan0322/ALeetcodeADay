//: [Previous](@previous)

import Foundation
/* Time exceed
 We could use hashtable to record the duplicate calculation. But TreeNode is not hashable unfortunately
 func rob(_ root: TreeNode?) -> Int {
       return traverse(root)
   }
   
   
   func traverse(_ root: TreeNode?) -> Int {
       guard let node = root else {
           return 0
       }
       
       var take = node.val
       if node.left != nil {
           take += traverse(node.left!.left)
           take += traverse(node.left!.right)
       }
       
       if node.right != nil {
           take += traverse(node.right!.left)
           take += traverse(node.right!.right)
       }
       
       let noTake = traverse(node.left) + traverse(node.right)
       return max(take,noTake)
       
   }
 */

typealias Choice = (notRob:Int, rob:Int)

func rob(_ root: TreeNode?) -> Int {
    let choice = traverse(root)
    return max(choice.notRob, choice.rob)
}


func traverse(_ root: TreeNode?) -> Choice {
    guard let node = root else {
        return Choice(0,0)
    }
    
    let left = traverse(node.left)
    let right = traverse(node.right)
    
    let notRob = max(left.rob, left.notRob) + max(right.rob, right.notRob)
    let rob = node.val + left.notRob + right.notRob
    
    
    return Choice(notRob, rob)
    
}

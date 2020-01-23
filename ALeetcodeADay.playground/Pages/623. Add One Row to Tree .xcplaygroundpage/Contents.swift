//: [Previous](@previous)

import Foundation

func addOneRow(_ root: TreeNode?, _ v: Int, _ d: Int) -> TreeNode? {
     guard let curNode = root else {
         return nil
     }
     
     guard d > 0 else {
         return nil
     }
     
     
     func traverse(node:TreeNode?, curDep: Int, isLeft:Bool) -> TreeNode? {
         if curDep == d {
             let newNode = TreeNode(v)
             if isLeft {
                 newNode.left = node
             } else {
                 newNode.right = node
             }
             return newNode
         } else {
             guard let n = node else {
                 return nil
             }
             
             if curDep > d {
                 return node
             } else {
                 n.left = traverse(node:n.left, curDep: curDep + 1, isLeft: true)
                 n.right = traverse(node:n.right, curDep: curDep + 1, isLeft: false)
                 return n
             }
         }
     }
     
     return traverse(node:curNode, curDep:1, isLeft:true)
     
     
 }

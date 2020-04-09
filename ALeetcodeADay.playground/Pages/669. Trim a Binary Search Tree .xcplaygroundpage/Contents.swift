//: [Previous](@previous)

import Foundation
/*
 
 669. Trim a Binary Search Tree 
 If the root value in the range [L, R]
       we need return the root, but trim its left and right subtree;
 else if the root value < L
       because of binary search tree property, the root and the left subtree are not in range;
       we need return trimmed right subtree.
 else
       similarly we need return trimmed left subtree.
 */

func trimBST(_ root: TreeNode?, _ L: Int, _ R: Int) -> TreeNode? {
      guard let node = root else {
          return nil
      }
      
      if node.val > R {
          return trimBST(node.left, L,R)
      } else if node.val < L {
          return trimBST(node.right, L, R)
      } else {
          node.left = trimBST(node.left, L,R)
          node.right = trimBST(node.right, L, R)
          return node
      }
  }

//: [Previous](@previous)

import Foundation
//369. Plus One Linked List

//Recursive can save state that previously visited (in a reversed order)
func plusOne(_ head: ListNode?) -> ListNode? {
     guard var node = head else {
         return nil
     }
     
     func plus(_ n:ListNode?) -> Int {
         guard var cur = n else {
             return 1
         }
         
        cur.val = cur.val + plus(cur.next)
         if cur.val == 10 {
             cur.val = 0
             return 1
         } else {
             return 0
         }
         
     }
     
     node.val = node.val + plus(node.next)
     
     if node.val == 10 {
         node.val = 0
         let newHead = ListNode(1)
         newHead.next = node
         return newHead
     } else {
         return node
     }
 }

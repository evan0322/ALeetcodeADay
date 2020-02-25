//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

func reorderList(_ head: ListNode?) {
     guard let node = head else {
         return
     }
     
     //Find the mid point of the linked list
     var p1: ListNode? = node
     var p2: ListNode? = node
     while p1 != nil && p2 != nil && p2!.next != nil {
         p1 = p1!.next
         p2 = p2!.next!.next
     }
     // 1->2->3->4->5
     //       p1    p2
     
     
     //Reverse list from the middle
     if p1!.next == nil {
         return
     }
     var pm: ListNode? = p1!.next!
     p1!.next = nil
     var pre: ListNode? = nil
     while pm != nil {
         let next = pm!.next
         pm!.next = pre
         pre = pm
         pm = next
     }
     pm = pre
     p1 = head
     //1->2->3   5->4
     //p1        pm
     
     //assemble two linked list together
     while p1 != nil && pm != nil {
         var p1n = p1!.next
         var pmn = pm!.next
         p1!.next = pm
         pm!.next = p1n
         p1 = p1n
         pm = pmn
     }
     //1->5->2->4->3

 }

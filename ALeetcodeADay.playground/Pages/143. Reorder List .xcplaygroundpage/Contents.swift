//: [Previous](@previous)

import Foundation

// 3 steps
func reorderList(_ head: ListNode?) {
    //[1, 2, 3, 4, 5, 6]
    guard let head = head else {
        return
    }
    
    var p1: ListNode? = head
    var p2: ListNode? = head
    
    // Step 1: find the middle point 3
    while p1 != nil && p2 != nil && p2!.next != nil {
        p1 = p1!.next!
        p2 = p2!.next!.next
    }
    
    //Step 2: reverse linked list after middle point -> [1, 2, 3, 6, 5 ,4]
    p1!.next = reverse(p1!.next)
            
    
    var p3: ListNode? = head
    var p4: ListNode? = p1!.next
    //This is important to aviod link cycle -> [1, 2, 3] [6, 5, 4]
    p1!.next = nil
    
    //Step 3: relink the linked list
    while p3 != nil && p4 != nil {
        let n3 = p3!.next
        let n4 = p4!.next
        
        p3!.next = p4
        p4!.next = n3
        
        p3 = n3
        p4 = n4
    }
    
    
}

func reverse(_ head: ListNode?) -> ListNode? {
    var pre: ListNode? = nil
    
    var cur = head
    while cur != nil {
        let next = cur!.next
        cur!.next = pre
        pre = cur
        cur = next
    }
    
    return pre
}

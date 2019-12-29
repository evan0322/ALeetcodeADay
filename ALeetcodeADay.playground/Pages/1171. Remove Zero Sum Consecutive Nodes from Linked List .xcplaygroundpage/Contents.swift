//: [Previous](@previous)

import Foundation

/*
 Think about how to do this when the input is an array.
 We scan from the begining, keeping track of the sum so far sum[0...i] in the hash table.
 If later we find the same sum, means sum[0...j] == sum[0...i], then we know that sum[i...j] is equat to zero. Note this range exclude element i but includ element j.
 
 For the scenario [1, -1], we add additional head to make it [0, 1, -1], so that 0 is already in the map when we reach index 2.
 */
func removeZeroSumSublists(_ head: ListNode?) -> ListNode? {
    let dummy = ListNode(0)
    dummy.next = head
    
    var p: ListNode? = dummy
    var preSum = 0
    var memo = [Int:ListNode]()
    
    while p != nil {
        let pointer = p!
        
        preSum += p!.val
        
        if let node = memo[preSum] {
            var cur = node.next
            var curSum = preSum
            while cur !== pointer {
                //cur != nil as node.next should not be nil
                curSum = curSum + cur!.val
                memo[curSum] = nil
                cur = cur!.next
            }
            node.next = p!.next
        } else {
            memo[preSum] = p!
        }
        
        p = p!.next
    }
    
    return dummy.next
    
}

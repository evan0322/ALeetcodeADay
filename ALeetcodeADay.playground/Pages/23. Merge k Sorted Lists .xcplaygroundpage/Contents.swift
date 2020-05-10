//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
     /*
         Brute force: Loop through the linked list, find out which linked list
     has the lowest value at the head. put that as the next node for the new list.
     Then move to the next node on that linked list. repeat the process.
     O(m * n) m: number of list. n: average length of the list
     
     Better: keep all the head of the linked list in a sorted array. find the smallest value in the array, put that as the node of the new linked list. Move to next node on that linked list. Use binary search to find the correct location of that new head to make the array still sorted. repeat the process
     O(n * logm) m: number of list. n: average length of the list
     */
     
     guard lists.count > 0 else {
         return nil
     }
     
     let newList = ListNode(0)
     var cursor = newList
     
     //Filter the nil list
     let lists = lists.compactMap{$0}
     
    var pq = PriorityQueue<ListNode>(elements: lists) { (node1, node2) -> Bool in
        return node1.val < node2.val
    }
    

     
    while pq.elements.count > 0 {
        let curNode = pq.dequeue()!
        cursor.next = curNode
        cursor = curNode
        
        if let nextNode = curNode.next {
            pq.enqueue(nextNode)
        }
     }
     
     return newList.next
 }
}

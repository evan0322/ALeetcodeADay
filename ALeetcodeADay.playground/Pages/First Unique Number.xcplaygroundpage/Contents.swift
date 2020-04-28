//: [Previous](@previous)

import Foundation

//First Unique Number
class FirstUnique {
    
    var map: [Int:DoubleListNode]
    var head = DoubleListNode(0)
    var tail = DoubleListNode(0)
    var dup = Set<Int>()

    init(_ nums: [Int]) {
        map = [Int:DoubleListNode]()
        
        head.next = tail
        tail.pre = head
        
        
        
        var memo = [Int:Int]()
        
        for num in nums {
            memo[num] = memo[num, default:0] + 1
        }
        
        for num in nums {
            let count = memo[num]!
            if count == 1 {
                
                let node = DoubleListNode(num)
                let preNode = tail.pre!
                
                node.next = tail
                tail.pre = node
                
                preNode.next = node
                node.pre = preNode
                
                map[num] = node
            } else {
                dup.insert(num)
            }
        }
    }
    
    func showFirstUnique() -> Int {
        let cur = head.next!
        return cur.val == 0 ? -1 : cur.val
    }
    
    func add(_ value: Int) {
        if dup.contains(value) {
           return
        } else if let node = map[value] {
            let pre = node.pre!
            let next = node.next!
            pre.next = next
            next.pre = pre
            map[value] = nil
            dup.insert(value)
        } else {
            let node = DoubleListNode(value)
            let preNode = tail.pre!
            
            node.next = tail
            tail.pre = node
            
            preNode.next = node
            node.pre = preNode
            
            map[value] = node
        }
    }
}

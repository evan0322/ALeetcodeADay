//: [Previous](@previous)

import Foundation

class MyCircularQueue {
    let capacity: Int
    var size = 0
    var head = 0
    var tail = -1
    var queue: [Int]

    /** Initialize your data structure here. Set the size of the queue to be k. */
    init(_ k: Int) {
        self.capacity = k
        self.queue = Array(repeating:0, count:capacity)
    }
    
    /** Insert an element into the circular queue. Return true if the operation is successful. */
    func enQueue(_ value: Int) -> Bool {
        if self.size == self.capacity {
            return false
        }
        self.tail = (self.tail + 1) % capacity
        self.queue[self.tail] = value
        self.size += 1
        return true
    }
    
    /** Delete an element from the circular queue. Return true if the operation is successful. */
    func deQueue() -> Bool {
        if self.size == 0 {
            return false
        }
        
        self.head = (self.head + 1) % capacity
        self.size -= 1
        return true
        
    }
    
    /** Get the front item from the queue. */
    func Front() -> Int {
        return self.size == 0 ? -1 : self.queue[self.head]
    }
    
    /** Get the last item from the queue. */
    func Rear() -> Int {
        return self.size == 0 ? -1 : self.queue[self.tail]
    }
    
    /** Checks whether the circular queue is empty or not. */
    func isEmpty() -> Bool {
        return self.size == 0
    }
    
    /** Checks whether the circular queue is full or not. */
    func isFull() -> Bool {
        return self.capacity == self.size
    }
}

/**
 * Your MyCircularQueue object will be instantiated and called as such:
 * let obj = MyCircularQueue(k)
 * let ret_1: Bool = obj.enQueue(value)
 * let ret_2: Bool = obj.deQueue()
 * let ret_3: Int = obj.Front()
 * let ret_4: Int = obj.Rear()
 * let ret_5: Bool = obj.isEmpty()
 * let ret_6: Bool = obj.isFull()
 */

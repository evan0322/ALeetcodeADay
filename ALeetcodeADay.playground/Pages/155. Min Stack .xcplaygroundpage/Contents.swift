//: [Previous](@previous)

import Foundation

//Solution 1: use 1 stack + customized class

class MinStackV1 {
    
    typealias Node = (val:Int, min:Int)
    var stack = [Node]()
    var small = Int.max
    
    /** initialize your data structure here. */
    init() {
        
    }
    
    func push(_ x: Int) {
        //We record the min that before the value is append
        stack.append(Node(val:x,min:small))
        small = min(small, x)
    }
    
    func pop() {
        if let node = stack.popLast() {
            small = node.min
        }
    }
    
    func top() -> Int {
        return stack.last!.val
    }
    
    func getMin() -> Int {
        return small
    }
}

// Solution 2: 2 stacks
class MinStackV2 {
    
    var stack: [Int]
    var minS: [Int]
    
    /** initialize your data structure here. */
    init() {
        stack = [Int]()
        minS = [Int]()
    }
    
    func push(_ x: Int) {
        if minS.count == 0 || minS.last! >= x {
            minS.append(x)
        }
        stack.append(x)
    }
    
    func pop() {
        let cur = stack.removeLast()
        if cur <= minS.last! {
            minS.removeLast()
        }
    }
    
    func top() -> Int {
        return stack.last!
    }
    
    func getMin() -> Int {
        return minS.last!
    }
}


//Solution 3 use 1 stack.
//We not only enqueue the element, also enqueue the previouse min val. When we detect that
//Pop will result in min val change, we dequeue one extra time to get the previous min
class MinStack {
    
    var stack: [Int]
    var minVal: Int
    
    /** initialize your data structure here. */
    init() {
        stack = [Int]()
        minVal = Int.max
    }
    
    func push(_ x: Int) {
        if x <= minVal {
            stack.append(minVal)
            minVal = x
        }
        stack.append(x)
    }
    
    func pop() {
        let cur = stack.removeLast()
        if cur <= minVal {
            minVal = stack.removeLast()
        }
    }
    
    func top() -> Int {
        return stack.last!
    }
    
    func getMin() -> Int {
        return minVal
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * let obj = MinStack()
 * obj.push(x)
 * obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Int = obj.getMin()
 */

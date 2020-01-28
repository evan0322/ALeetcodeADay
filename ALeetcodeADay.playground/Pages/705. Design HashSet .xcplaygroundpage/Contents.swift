//: [Previous](@previous)

import Foundation

class MyHashSet {
    var set: [[Int]]

    /** Initialize your data structure here. */
    init() {
        self.set = Array(repeating:[Int](), count:1001)
    }
    
    func add(_ key: Int) {
        let remain = key % 1000
        var nums = self.set[remain]
        for num in nums {
            if num == key {
                return
            }
        }
        
        self.set[remain] = nums + [key]
    }
    
    func remove(_ key: Int) {
        let remain = key % 1000
        var nums = self.set[remain]
        var index = -1
        for i in 0..<nums.count {
            if nums[i] == key {
                index = i
                break
            }
        }
        
        if index != -1 {
            nums.remove(at:index)
            self.set[remain] = nums
        }
        
    }
    
    /** Returns true if this set contains the specified element */
    func contains(_ key: Int) -> Bool {
        let remain = key % 1000
        let nums = self.set[remain]
        for num in nums {
            if num == key {
                return true
            }
        }
        
        return false
    }
}

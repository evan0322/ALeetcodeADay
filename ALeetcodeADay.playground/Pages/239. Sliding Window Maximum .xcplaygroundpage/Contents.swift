//: [Previous](@previous)

import Foundation

func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    //Monotonic Queue: Keep track of the max/min value visited in O(1)
    guard nums.count > 0, k <= nums.count else {
        return [Int]()
    }
    var result = [Int]()
    
    var queue = monQueue()
    
    for i in 0..<nums.count {
        if i < k - 1 {
            queue.enqueue(nums[i])
        } else if i == k - 1 {
            queue.enqueue(nums[i])
            result.append(queue.getHead())
        } else {
            queue.remove(nums[i - k])
            queue.enqueue(nums[i])
            result.append(queue.getHead())
        }
    }
    
    return result
    
}

class monQueue {
    var nums = [Int]()
    
    func enqueue(_ num:Int) {
        while nums.count > 0 && nums.last! < num {
            nums.removeLast()
        }
        nums.append(num)
    }
    
    func getHead() -> Int {
        return nums.count > 0 ? nums.first! : -1
    }
    
    func remove(_ num:Int) {
        if num == getHead() {
            nums.removeFirst()
        }
    }
}

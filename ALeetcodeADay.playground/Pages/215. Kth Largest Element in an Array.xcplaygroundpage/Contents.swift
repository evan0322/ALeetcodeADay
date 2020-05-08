//: [Previous](@previous)

import Foundation

//215. Kth Largest Element in an Array
//use random pivot to ensure that time complexity is good with special test case
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    guard nums.count > 0, k > 0 else {
        return -1
    }
    
    var index = -1
    var nums = nums
    /*
    [3, 2, 1, 5, 6, 4]
    [1, 2, 3, 4, 5, 6]
    k = 2
    
    nums.count - k
    */
    func quickSelect(nums:inout [Int], low:Int, high:Int) {
        if low < high {
            let pivot = partition(nums:&nums, low:low, high:high)
            if pivot == nums.count - k {
                index = pivot
                return
            } else if pivot > nums.count - k {
                quickSelect(nums:&nums, low:low, high:pivot - 1)
            } else {
                quickSelect(nums:&nums, low:pivot + 1, high:high)
            }
        }
    }

    func partition(nums:inout [Int], low:Int, high:Int) -> Int {
        let index = Int.random(in: low...high)
        let pivotVal = nums[index]
        nums.swapAt(index,high)
        
        var i = low
        for j in low..<high {
            if nums[j] <= pivotVal {
                nums.swapAt(i, j)
                i += 1
            }
        }

        nums.swapAt(i, high)
        return i
    }

    quickSelect(nums:&nums,low:0, high:nums.count - 1)
    
    return index == -1 ? nums[nums.count - k] : nums[index]
}



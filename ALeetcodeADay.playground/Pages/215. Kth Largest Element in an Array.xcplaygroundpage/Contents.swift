//: [Previous](@previous)

import Foundation

//215. Kth Largest Element in an Array
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    
    var nums = nums
    let result = quickSort(nums:&nums, low:0, high:nums.count - 1, target: k)
    if result == -1 {
        return nums[nums.count - k]
    } else {
        return result
    }
}


func quickSort(nums: inout [Int], low: Int, high: Int, target: Int) -> Int {
    if low < high {
        let pivot = partition(nums:&nums, low:low, high:high)
        if pivot == nums.count - target {
            return nums[pivot]
        }
        
        if pivot > nums.count - target {
            return quickSort(nums:&nums, low:low, high: pivot - 1, target:target)
        } else {
            return quickSort(nums:&nums, low:pivot + 1, high: high, target:target)
        }
    }
    
    return -1
}

func partition(nums: inout [Int], low: Int, high: Int) -> Int {
    let pivot = nums[high]
    var i = low
    
    for j in i..<high {
        if nums[j] <= pivot {
            nums.swapAt(i, j)
            i += 1
        }
    }
    
    nums.swapAt(i, high)
    return i
}

//: [Previous](@previous)

import Foundation
//34. Find First and Last Position of Element in Sorted Array
func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    guard nums.count > 0 else {
        return [-1,-1]
    }
    
    let low = binarySearchLower(nums: nums, target: target)
    let high = binarySearchUpper(nums: nums, target: target)
    
    if low == -1 {
        return [-1, -1]
    } else if high == -1 {
        return [low, nums.count - 1]
    } else {
        return [low, high - 1]
    }
}


// Return the first element in [low, high) that is larger or equal to value
func binarySearchLower(nums:[Int], target:Int) -> Int {
    guard nums.count > 0 else {
        return -1
    }
    
    var low = 0
    var high = nums.count
    
    while low < high {
        let mid = low + (high - low)/2
        
        if nums[mid] < target {
            low = mid + 1
        } else {
            high = mid
        }
    }
    
    //if low == high and low is out of the searching boundary
    //or if the first element in the array that is larger or equal to value is not the value itself
    if low == nums.count || nums[low] != target {
        return -1
    } else {
        return low
    }
}

// Return the first element in [low, high) that is larger than value
func binarySearchUpper(nums:[Int], target:Int) -> Int {
    guard nums.count > 0 else {
        return -1
    }
    
    var low = 0
    var high = nums.count
    
    while low < high {
        let mid = low + (high - low)/2
        
        if nums[mid] <= target {
            low = mid + 1
        } else {
            high = mid
        }
    }
    
    //if low == high and low is out of the searching boundary
    //or if the first element in the array that is larger than value is the first element
    //or if the previous element of the found element (first element in [low, high) that is larger than value) is not target
    if low == nums.count || low == 0 || nums[low - 1] != target {
        return -1
    } else {
        return low
    }
}

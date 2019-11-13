
import Foundation

// Binary Search
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


var index = binarySearchLower(array: [-1, 0, 0, 3, 3, 3, 7, 8, 9], value: 10)

print(index)

//: [Previous](@previous)

import Foundation


//540. Single Element in a Sorted Array
//Binary Search
func singleNonDuplicate(_ nums: [Int]) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    
    var lo = 0
    var hi = nums.count
    
    while lo < hi {
        let mid = lo + (hi - lo)/2
        if (mid % 2 == 0 && mid + 1 < nums.count && nums[mid] == nums[mid + 1]) || (mid % 2 == 1 && mid - 1 >= 0 && nums[mid] == nums[mid - 1]) {
            lo = mid + 1
        } else {
            hi = mid
        }
    }
    
    return nums[lo]
}

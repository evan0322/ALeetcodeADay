//: [Previous](@previous)

import Foundation

//1. In reverse order, find the first element that smaller than previous element
//2. from the found element, travel toward the end of the array, until the smallest element that larger than the found element.
//3. swap these two
//4. we need to sort the resest of the array in ascending order. Since we are already travelling in descending order, we can simply swap the element.
//Note the edge cases
func nextPermutation(_ nums: inout [Int]) {
    // 16779863 -> 16789763
    // 123 -> 132
    // 167798 -> 167897
    
    guard nums.count > 1 else {
        return
    }
    
    for i in (0..<nums.count).reversed() {
        if i == nums.count - 1 {
            continue
        } else {
            if nums[i] < nums[i + 1] {
                var j = i + 1
                while j < nums.count {
                    if nums[j] <= nums[i] {
                        break
                    }
                    j += 1
                }
                
                nums.swapAt(i , j - 1)
                
                var low = i + 1
                var high = nums.count - 1
                
                while low < nums.count && high < nums.count && low < high {
                    nums.swapAt(low, high)
                    low += 1
                    high -= 1
                }
                return
            }
        }
    }
    
    nums.reverse()
}

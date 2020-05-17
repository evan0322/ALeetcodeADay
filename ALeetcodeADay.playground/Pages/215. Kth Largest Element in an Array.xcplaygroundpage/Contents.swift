//: [Previous](@previous)

import Foundation

//215. Kth Largest Element in an Array
/*
 Approach 1: Sort and then find the kth largest element
 TC: Depend on the sorting algorithm. Average nlogn
 SC: Depend on the sorting algorithm. Average n
 Pros: The input will in sorted order. It will be easier to find the next required num
 Cons: Not optimal
 
 Approach 2: Priority Queue (Min Heap)
 Use PQ to keep track of the largest k element. Once the total num exceeds k, poll the
 smallest element fro mthe PQ
 TC: nlogk
 SC: k
 Pros: Efficient.
 Cons: Uses more space
 
 Aproach 3: Quick Select
 TC: n
 SC: O(1)
 Pro: Efficient
 Cons: The result of the nums are not in sorted order
 */
 
 
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
     
     
     [3, 2, 1, 5, 5, 6]
     nums.count - k = 3
     pi = 4
     
     
     lo = 0
     hi = 3
     [3, 2, 1, 5, 5, 6]
     pi = 3
     
     */
     
     
     func quickSelect(nums:inout [Int], low:Int, high:Int) {
         if low < high {
             let pivotIndex = partition(nums:&nums, low:low, high:high)
             if pivotIndex == nums.count - k {
                 index = pivotIndex
             } else if pivotIndex < nums.count - k {
                 quickSelect(nums:&nums,low:pivotIndex + 1, high:high)
             } else {
                 quickSelect(nums:&nums,low:low, high:pivotIndex - 1)
             }
         }
     }
     
     
     func partition(nums:inout [Int], low:Int, high:Int) -> Int {
         let randomIndex = Int.random(in:low...high)
         nums.swapAt(randomIndex, high)
         let pivot = nums[high]
 
         var i = low
         for j in low..<high {
             if nums[j] <= pivot {
                 nums.swapAt(i, j)
                 i += 1
             }
         }
         
         nums.swapAt(i, high)
         return i
     }
     
     quickSelect(nums:&nums, low:0, high:nums.count - 1)
     
     return index == -1 ? nums[nums.count - k] : nums[index]
 }
 
 
 



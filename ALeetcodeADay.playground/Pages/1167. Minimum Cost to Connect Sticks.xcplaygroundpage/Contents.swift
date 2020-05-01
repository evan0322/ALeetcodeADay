//: [Previous](@previous)

import Foundation

/*
 [1, 8, 3, 5]
   [9, 8]
     [17]
 
 (1 + 8) * 2 + (3 + 5) * 2
 
 Smaller length sticks should be connected first as they will give less cost in the end
 [1, 8, 3, 5]
 [1, 3, 5, 8]
 
 [4, 5, 8] 4
 [9, 8] 13
 [17] 30
 
 
 after each merge, the new stick should be put a proper place to determine which stick should be merge next (binary search)
 
 */
 func connectSticks(_ sticks: [Int]) -> Int {
     guard sticks.count > 1 else {
         return 0
     }
     
     var sticks = sticks.sorted{ $0 < $1 }
     var result = 0
     
     while sticks.count > 1{
         let first = sticks.removeFirst()
         let second = sticks.removeFirst()
         let newStick = first + second
         result += newStick
         
         let index = binarySearch(sticks, newStick)
         sticks.insert(newStick,at:index)
     }
     
     return result
     
 }
 
 
 func binarySearch(_ nums:[Int], _ target:Int) -> Int {
     var lo = 0
     var hi = nums.count
     
     while lo < hi {
         let mid = lo + (hi - lo)/2
         if nums[mid] < target {
             lo = mid + 1
         } else {
             hi = mid
         }
     }
     
     return lo
 }

//: [Previous](@previous)

import Foundation


//Put each element to the final position without affecting other elements
func duplicateZeros(_ arr: inout [Int]) {
     var zeros = 0
     
     for num in arr {
         if num == 0 {
             zeros += 1
         }
     }
     
     
     for i in (0..<arr.count).reversed() {
         if arr[i] == 0 {
             zeros -= 1
             
             let j = i + zeros
             if j < arr.count {
                 arr[j] = 0
             }
             
             if j + 1 < arr.count {
                 arr[j + 1] = 0
             }
         } else {
             let j = i + zeros
             if j < arr.count {
                 arr[j] = arr[i]
             }
         }
     }
     
 }

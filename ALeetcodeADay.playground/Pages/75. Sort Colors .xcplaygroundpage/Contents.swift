
import Foundation

//https://en.wikipedia.org/wiki/Dutch_national_flag_problem
 func sortColors(_ nums: inout [Int]) {
     var red = 0
     var white = 0
     var undefine = nums.count - 1
     
     while white <= undefine {
         if nums[white] == 0 {
             nums.swapAt(red, white)
             red += 1
             white += 1
         } else if nums[white]  == 1 {
             white += 1
         } else {
             nums.swapAt(white, undefine)
             undefine -= 1
         }
     }
 }

//: [Previous](@previous)

import Foundation

func missingElement(_ nums: [Int], _ k: Int) -> Int {
     guard nums.count > 1, k > 0 else {
         return 0
     }
    
     //Total count of missing num between n[i] and n[j] is n[j] - n[i] - 1 - (j - i - 1) = n[j] - n[i] - (j - i)
    
    let n = nums.count
    let missing = nums[n - 1] - nums[0] + 1 - n;
    if missing < k {
        return nums.last! + k - missing
    }
     
     var low = 0
     var high = nums.count
     
     while low < high {
         let mid = low + (high - low)/2
         let missing = nums[mid] - mid - nums[0]
         if missing < k {
             low = mid + 1
         } else {
             high = mid
         }
     }
     
     //low: First element that missing element exceed k
     /*
     The missing num is between low - 1 and low
     missing element between low - 1 and 0 is m = n[low - 1] - n[0] - (low - 1 - 0)
     we still need k - m element after low - 1 to reach k.
     
     result = num[low - 1] + k - (n[low - 1] - n[0] - (low - 1 - 0)) = nums[0] + k + low - 1
     
     */
     
     return nums[0] + k + low - 1
 }

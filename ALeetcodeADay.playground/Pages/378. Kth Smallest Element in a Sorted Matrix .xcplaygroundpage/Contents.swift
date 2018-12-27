
import Foundation

class Solution {
    //378. Kth Smallest Element in a Sorted Matrix
    //Do a binary search, to find the num of elements that less than target num. If we find that k - 1 elements are less than target, then we find the answer
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        var lo = matrix[0][0]
        var hi = matrix[matrix.count - 1][matrix[0].count - 1] + 1
        
        
        
        while lo < hi {
            let mid = lo + (hi - lo)/2
            if numCountLess(than: mid, in: matrix) < k {
                lo = mid + 1
            } else {
                hi = mid
            }
        }
        
        return lo
    }
    
    
    func numCountLess(than num:Int, in matrix:[[Int]]) -> Int {
        var count = 0
        var j = matrix[0].count - 1
        for i in 0..<matrix.count {
            while j >= 0 && matrix[i][j] > num {
                j -= 1
            }
            count += j + 1
        }
        
        return count
    }
}

       
      

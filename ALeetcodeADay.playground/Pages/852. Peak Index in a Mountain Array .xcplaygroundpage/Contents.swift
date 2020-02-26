//: [Previous](@previous)

import Foundation

func peakIndexInMountainArray(_ A: [Int]) -> Int {
    //         for i in 1..<A.count - 1 {
    //             if A[i] > A[i - 1] && A[i] > A[i + 1] {
    //                 return i
    //             }
    //         }
    
    //         return -1
    //[ 1 2 3 4 5 4 3 2]
    
    var lo = 0
    var hi = A.count
    
    while lo < hi {
        let mid = lo + (hi - lo)/2
        if A[mid] > A[mid - 1] && A[mid] > A[mid + 1] {
            return mid
        } else if A[mid] > A[mid - 1] {
            //Raising
            lo = mid + 1
        } else {
            //Decreasing
            hi = mid
        }
    }
    
    return lo
}

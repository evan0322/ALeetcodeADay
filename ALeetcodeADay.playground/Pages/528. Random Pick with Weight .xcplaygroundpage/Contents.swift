//: [Previous](@previous)

import Foundation

var total = 0
var preSum = [Int]()

init(_ w: [Int]) {
    for i in 0..<w.count {
        let weight = w[i]
        if i == 0 {
            preSum.append(weight)
        } else {
            preSum.append(preSum[i - 1] + weight)
        }
    }
    
    if preSum.count > 0 {
        total = preSum.last!
    }
}

func pickIndex() -> Int {
    let pick = Int.random(in:1...total)
    //[3, 6] -> [1,2,3 ->0  4, 5, 6 -> 1]
    
    //Find first element that larger than pick
    let index = binarySearch(preSum, pick)
    
    
    return index
}

func binarySearch(_ nums:[Int],_ target:Int) -> Int {
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

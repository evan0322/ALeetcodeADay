//: [Previous](@previous)

import Foundation

//This problem can be translate into "find max number of none-overlaping intervals"
//We can use greedy to calcaulate the value. Then the min number of over lapping interval can be calcaulated.


func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
    guard intervals.count > 1 else {
        return 0
    }
    
    
    var intervals = intervals
    intervals.sort(by:{ $0[1] < $1[1] })
    
    var end = intervals.first![1]
    var count = 1
    
    for i in 1..<intervals.count {
        if intervals[i][0] >= end {
            count += 1
            end = intervals[i][1]
        }
    }
    
    return intervals.count - count
}

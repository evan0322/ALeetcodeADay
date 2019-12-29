//: [Previous](@previous)

import Foundation

//find the interval that does not need to be merged, and merge the interval that needs to be merged one by one
//57. Insert Interval

func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
    var result = [[Int]]()
  
    var i = 0
    
    while i < intervals.count && intervals[i][1] < newInterval[0] {
        result.append(intervals[i])
        i += 1
    }
    
    var merge = newInterval
    
    while i < intervals.count && intervals[i][0] <= newInterval[1] {
        merge = [min(merge[0], intervals[i][0]), max(merge[1], intervals[i][1])]
        i += 1
    }
    
    result.append(merge)
    
    while i < intervals.count {
        result.append(intervals[i])
        i += 1
    }
    
    
    return result
}

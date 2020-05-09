//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

func merge(_ intervals: [[Int]]) -> [[Int]] {
    guard intervals.count > 0 else {
        return [[Int]]()
    }
    
    var result = [[Int]]()
    
    let intervals = intervals.sorted{ $0[0] < $1[0] }
    
    for interval in intervals {
        if result.count == 0 {
            result.append(interval)
        } else {

            let pre = result.last!
            // ----
            //        ----
            if interval[0] > pre[1] {
                result.append(interval)
            //  ---
            //  ----
            
            //  ----
            //   ----
            
            // ----
            //  --
            } else {
                result.removeLast()
                let start = min(interval[0], pre[0])
                let end = max(interval[1], pre[1])
                result.append([start,end])
            }
        }
    }
    
    return result
}

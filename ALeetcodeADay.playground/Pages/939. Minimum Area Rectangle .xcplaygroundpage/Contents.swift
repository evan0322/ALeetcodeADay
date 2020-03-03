//: [Previous](@previous)

import Foundation

func minAreaRect(_ points: [[Int]]) -> Int {
    var minArea = Int.max
    var memo = Set<[String]>()
    for point in points {
        memo.insert("\(point[0]),\(point[1])")
    }
    
    for i in 0..<points.count {
        for j in 0..<i {
            let x1 = points[i][0]
            let y1 = points[i][1]
            let x2 = points[j][0]
            let y2 = points[j][1]
            
            if x1 != x2 && y1 != y2 {
                if memo.contains("\(x1),\(y2)") && memo.contains("\(x2),\(y1)") {
                    minArea = min(minArea, abs(x1 - x2) * abs(y1 - y2))
                }
            }
        }
    }
    
    return minArea == Int.max ? 0 : minArea
}

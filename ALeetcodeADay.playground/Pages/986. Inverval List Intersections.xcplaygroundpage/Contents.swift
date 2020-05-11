//: [Previous](@previous)

import Foundation

//986. Interval List Intersections
/*
A = [[0,2],[5,10],[13,23],[24,25]]
B = [[1,5],[8,12],[15,24],[25,26]]
*/
func intervalIntersection(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
guard A.count > 0, B.count > 0 else {
    return [[Int]]()
}

var i = 0
var j = 0

var result = [[Int]]()

while i < A.count && j < B.count {
    let a = A[i]
    let b = B[j]
    
    if b[1] >= a[1] {
        if b[0] > a[1] {
            i += 1
        } else {
            result.append([max(a[0], b[0]), min(a[1], b[1])])
            i += 1
        }
    } else {
        if a[0] > b[1] {
            j += 1
        } else {
            result.append([max(a[0], b[0]), min(a[1], b[1])])
            j += 1
        }
    }
}
        
return result
}

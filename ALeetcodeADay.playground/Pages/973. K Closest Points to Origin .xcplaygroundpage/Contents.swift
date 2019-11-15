//: [Previous](@previous)

import Foundation

//973. K Closest Points to Origin

func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
    guard points.count > 0, K <= points.count else {
        return [[Int]]()
    }
    
    
    var cPoints = points
    
    cPoints.sort{ (pow(Double($0[0]),2) + pow(Double($0[1]),2)).squareRoot() < (pow(Double($1[0]),2) + pow(Double($1[1]),2)).squareRoot()}
            
    
    return Array(cPoints[0..<K])
}

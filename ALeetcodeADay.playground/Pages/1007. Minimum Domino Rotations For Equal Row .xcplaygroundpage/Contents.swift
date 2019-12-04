//: [Previous](@previous)

import Foundation


func minDominoRotations(_ A: [Int], _ B: [Int]) -> Int {
     guard A.count > 0, B.count > 0 , A.count == B.count else {
         return -1
     }
     
     var aCount = Array(repeating:0, count:7)
     var bCount = Array(repeating:0, count:7)
     var sameCount = Array(repeating:0, count:7)
     
     for i in 0..<A.count {
         aCount[A[i]] += 1
         bCount[B[i]] += 1
         
         if A[i] == B[i] {
             sameCount[A[i]] += 1
         }
     }
     
     
     for i in 1...6 {
        
         if aCount[i] + bCount[i] - sameCount[i] == A.count {
             return A.count - max(aCount[i], bCount[i])
         }
     }
     
     return -1
  
 }

//: [Previous](@previous)

import Foundation

//1101. The Earliest Moment When Everyone Become Friends
func earliestAcq(_ logs: [[Int]], _ N: Int) -> Int {
     guard logs.count > 0 else {
         return -1
     }
     
     var ufs = UnionFindSet<Int>()
     
     var logs = logs.sorted(by:{ $0[0] < $1[0] })
     
     for log in logs {
         if ufs.find(log[1]) == nil {
             ufs.add(log[1])
         }
         
         if ufs.find(log[2]) == nil {
             ufs.add(log[2])
         }
         
         ufs.union(log[1], log[2])
         if ufs.count == 1 && ufs.size.count == N {
             return log[0]
         }
     }
     
     return -1
 }

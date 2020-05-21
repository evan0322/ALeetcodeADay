//: [Previous](@previous)

import Foundation

func assignBikes(_ workers: [[Int]], _ bikes: [[Int]]) -> [Int] {
      //n <= m
      /*
      typealias Pair = (worker:Int, bike:Int, dis:Int)

      var pairs = [Pair]()
      
      for i in 0..<workers.count {
          for j in 0..<bikes.count {
              pairs.append(Pair(i,j, abs(workers[i][0] - bikes[j][0]) + abs(workers[i][1] - bikes[j][1])))
          }
      }
      
      pairs.sort{(left,right) -> Bool in
          if left.dis != right.dis {
              return left.dis < right.dis
          } else if left.worker != right.worker {
              return left.worker < right.worker
          } else {
              return left.bike < right.bike
          }
      }
      
      var workerMemo = Set<Int>()
      var bikeMemo = Set<Int>()
      var result = Array(repeating:-1, count:workers.count)
      
      
      for pair in pairs {
          if !workerMemo.contains(pair.worker) && !bikeMemo.contains(pair.bike) {
              result[pair.worker] = pair.bike
              workerMemo.insert(pair.worker)
              bikeMemo.insert(pair.bike)
          }
      }
      
      return result
      
       */
      
     //O(M * N)
      
     var buckets = Array(repeating:[[Int]](), count:2001)
     
     
     //Put worker first, then the bike, to ensure that for the same distance, the one with lower worker
     // index has high priority
     for i in 0..<workers.count {
         for j in 0..<bikes.count {
             let dis = abs(workers[i][0] - bikes[j][0]) + abs(workers[i][1] - bikes[j][1])
             buckets[dis].append([i, j])
         }
     }
      
     var workerMemo = Set<Int>()
     var bikeMemo = Set<Int>()
     var result = Array(repeating:-1, count:workers.count)
      
     for bucket in buckets where bucket.count > 0 {
         for pair in bucket {
             if !workerMemo.contains(pair[0]) && !bikeMemo.contains(pair[1]) {
                  result[pair[0]] = pair[1]
                  workerMemo.insert(pair[0])
                  bikeMemo.insert(pair[1])
                 continue
             }
         }
      }
      
      return result
  }

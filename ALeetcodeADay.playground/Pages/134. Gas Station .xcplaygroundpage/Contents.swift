//: [Previous](@previous)

import Foundation

func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
     guard gas.count == cost.count, gas.count > 0 else {
         return -1
     }
     var tank = [Int]()
     var sum = 0
     
     for i in 0..<gas.count {
         tank.append(gas[i] - cost[i])
         sum += tank[i]
     }
     
     if sum < 0 {
         return -1
     }
     
     var curSum = 0
     var start = 0
     
     for i in 0..<tank.count {
         curSum += tank[i]
         if curSum < 0 {
             curSum = 0
             start = i + 1
         }
     }
     
     return start
 }

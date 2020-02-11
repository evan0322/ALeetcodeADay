//: [Previous](@previous)

import Foundation

/*
 Assumptions
 1. If total gas is more than total consumption, there is always a solution.
 2. If station i cannot reach station j, any node in [i + 1..<j] cannot reach j.
 
 We start from station 0. If tank[i] < 0, then:
 1. Any station in [0..<i] we have already checked. They does not reach a certain station
 2. Any station in [i..<j] cannot reach j.
 
 --> the answer is not in [0..<j]
*/
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

//: [Previous](@previous)

import Foundation
/*
 First count the number of occurrences of each element.
 Let the max frequency seen be M for element E
 We can schedule the first M-1 occurrences of E, each E will be followed by at least N CPU cycles in between successive schedules of E
 Total CPU cycles after scheduling M-1 occurrences of E = (M-1) * (N + 1) // 1 comes for the CPU cycle for E itself
 Now schedule the final round of tasks. We will need at least 1 CPU cycle of the last occurrence of E. If there are multiple tasks with frequency M, they will all need 1 more cycle.
 Run through the frequency dictionary and for every element which has frequency == M, add 1 cycle to result.
 If we have more number of tasks than the max slots we need as computed above we will return the length of the tasks array as we need at least those many CPU cycles.
 
 */
 func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
     guard tasks.count > 0 else {
         return 0
     }
     
     var memo = [Character:Int]()
     var maxCount = 1
     
     for task in tasks {
         if var count = memo[task] {
             count += 1
             maxCount = max(maxCount, count)
             memo[task] = count
         } else {
             memo[task] = 1
         }
     }
     
     var result = (maxCount - 1) * (n + 1)
     
     for (key, value) in memo {
         if value == maxCount {
             result += 1
         }
     }
     
     return max(result, tasks.count)
 }
    
}

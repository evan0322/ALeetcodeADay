//: [Previous](@previous)

import Foundation
/*
 Take [A, A, A, B, B, B] for example. We first find the task that apears most frequently,
 Build the task : A * * A * * A * *.  Between A * * A * * A, if the taks appears less than A, then we are sure that we can put the task in  the slots without conflicting the cool down. However, If B appears the same time as A, then B must be put outside of A * * A * * A, then make it A B * A B * A B
 We call everying after the last A tail, the length of tail is equal to the number of tasks that appears the same frequence as the most frequent task.
 After the tail is calculated and restriction is set, if the rest of the task is larger or eaqual in the slots, then basically the length of the taks is a parlindrome of the task itself, then return tasks.count. If  the task is less than the slots, then we need to calculate the length based on the slots.
 */

func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
    guard tasks.count > 0 else {
        return 0
    }
    
    var memo = [Character:Int]()
    var max = 0
    var mChar: Character = "*"
    var tail = 0
    
    for t in tasks {
        memo[t] = memo[t, default: 0] + 1
        if memo[t]! > max {
            mChar = t
            max = memo[t]!
        }
    }
    
    for key in memo.keys {
        if memo[key]! == max {
            tail += 1
        }
    }
    
    tail -= 1
    let slots = (max - 1) * n
    
    if tasks.count - max - tail > slots {
        return tasks.count
    } else {
        return slots + max + tail
    }
    
}

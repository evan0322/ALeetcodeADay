//: [Previous](@previous)

import Foundation

//http://goo.gl/64Nams
func majorityElement(_ nums: [Int]) -> [Int] {
    guard nums.count > 0 else {
        return [Int]()
    }
    
    var can1 = 0
    var can2 = 1
    
    var count1 = 0
    var count2 = 0
    
    for n in nums {
        if n == can1 {
            count1 += 1
        } else if n == can2 {
            count2 += 1
        } else if count1 == 0 {
            can1 = n
            count1 = 1
        } else if count2 == 0 {
            can2 = n
            count2 = 1
        } else {
            count1 -= 1
            count2 -= 1
        }
    }
    
    count1 = 0
    count2 = 0
    var result = [Int]()
    
    for n in nums {
        if n == can1 {
            count1 += 1
        } else if n == can2 {
            count2 += 1
        }
    }
    
    if count1 > nums.count/3 {
        result.append(can1)
    }
    
    if count2 > nums.count/3 {
        result.append(can2)
    }
    
    return result
    
    
}

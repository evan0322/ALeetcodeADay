//: [Previous](@previous)

import Foundation


//Use binary search. For each house, perform binary search to find the closest heater. Keep track of a maximum distance you will get the answer
func findRadius(_ houses: [Int], _ heaters: [Int]) -> Int {
    
    var heaters = heaters.sorted()
    
    var result = 0
    
    for h in houses {
        let distance = abs(h - findClosest(house:h, heaters:heaters))
        result = max(distance, result)
    }
    
    return result
    
}

func findClosest(house:Int, heaters:[Int]) -> Int {
    var lo = 0
    var hi = heaters.count - 1
    
    while lo < hi {
        let mid = lo + (hi - lo)/2
        if house > heaters[mid] {
            lo = mid + 1
        } else {
            hi = mid
        }
    }
    
    if lo > 0 {
        return heaters[lo] - house > house - heaters[lo - 1] ? heaters[lo - 1] : heaters[lo]
    } else {
        return heaters[lo]
    }
}

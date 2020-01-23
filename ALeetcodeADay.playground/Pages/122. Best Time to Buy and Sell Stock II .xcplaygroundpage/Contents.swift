//: [Previous](@previous)

import Foundation

func maxProfit(_ prices: [Int]) -> Int {
    guard prices.count > 1 else {
        return 0
    }
    
    var i = 1
    var result = 0
    
    while i < prices.count {
        while i < prices.count && prices[i] <= prices[i - 1] {
            i += 1
        }
        
        var curMin = prices[i - 1]
        
        while i < prices.count && prices[i] > prices[i - 1] {
            i += 1
        }
        
        var curMax = prices[i - 1]
        
        result += curMax - curMin
    }
    
    return result
}

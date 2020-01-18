//: [Previous](@previous)

import Foundation

func longestOnes(_ A: [Int], _ K: Int) -> Int {
    guard A.count > 0 else {
        return 0
    }
    
    var i = 0
    var j = 0
    var result = 0
    var k = K
    
    while j < A.count {
        if A[j] == 0 {
            k -= 1
            while k < 0{
                if A[i] == 0 {
                    i += 1
                    k += 1
                } else {
                    i += 1
                }
            }
        }
            
        result = max(result, j - i + 1)
        j += 1
        
    }
    
    return result
}

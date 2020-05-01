//: [Previous](@previous)

import Foundation
/*
 Find the index that does not cut any of the intervals that in [left,index]
       |   b   |
   |         a       |
   0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 151 6 17 18 19 20 21 22 23 24
           |   c   |
*/
func partitionLabels(_ S: String) -> [Int] {
    guard S.count > 0 else {
        return [Int]()
    }
    
    let S = S.map{String($0)}
    var memo = [String:Int]()
    
    for i in 0..<S.count {
        //We only have to record the right most index of the appearance of a character
        let char = S[i]
        memo[char] =  i
    }
    
    var left = 0
    var  result = [Int]()
    var right = 0
    
    for i in 0..<S.count {
        let char = S[i]
        let index = memo[char]!
        right = max(index, right)
        
        if i == right {
            result.append(right - left + 1)
            left = right + 1
        }
    }
    
    return result
    
}

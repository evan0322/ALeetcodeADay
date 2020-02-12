//: [Previous](@previous)

import Foundation
/*
 Let's try to repeatedly choose the smallest left-justified partition. Consider the first label, say it's 'a'. The first partition must include it, and also the last occurrence of 'a'. However, between those two occurrences of 'a', there could be other labels that make the minimum size of this partition bigger. For example, in "abccaddbeffe", the minimum first partition is "abccaddb". This gives us the idea for the algorithm: For each letter encountered, process the last occurrence of that letter, extending the current partition [anchor, j] appropriately.
 */

func partitionLabels(_ S: String) -> [Int] {
    guard S.count > 0 else {
        return [Int]()
    }
    
    let S = S.map{String($0)}
    var memo = [String:Int]()
   
    for i in 0..<S.count {
        memo[S[i]] = i
    }
    
    var result = [Int]()
    var left = 0
    var right = 0
    
    for i in 0..<S.count {
        let pos = memo[S[i]]!
        right = max(right, pos)
        if right == i {
            result.append(i - left + 1)
            left = right + 1
        }
        
    }
    
    return result
    
    
}

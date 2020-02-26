//: [Previous](@previous)

import Foundation
/*
 init -> O(n)
 
 find -> O(n)
 */
class WordDistance {
    var memo = [String:[Int]]()
    
    init(_ words: [String]) {
        for i in 0..<words.count {
            memo[words[i]] = memo[words[i], default:[Int]()] + [i]
        }
    }
    
    func shortest(_ word1: String, _ word2: String) -> Int {
        let index1 = memo[word1]!
        let index2 = memo[word2]!
        
        var i = 0
        var j = 0
        
        var result = Int.max
        
        while i < index1.count && j < index2.count {
            result = min(result, abs(index1[i] - index2[j]))
            if index1[i] < index2[j] {
                i += 1
            } else {
                j += 1
            }
        }
        
        return result
    }
}

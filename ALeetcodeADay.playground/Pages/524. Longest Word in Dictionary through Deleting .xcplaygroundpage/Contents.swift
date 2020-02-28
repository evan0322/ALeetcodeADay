//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//O(MN)
func findLongestWord(_ s: String, _ d: [String]) -> String {
    var result = ""
    
    for word in d {
        if word.count >= result.count && hasSubSeq(s, word) {
            if word.count > result.count {
                result = word
            } else if word.count == result.count && word < result {
                result = word
            }
             
        }
    }
    
    return result
}

func hasSubSeq(_ s: String, _ d: String) -> Bool {
    var s = s.map{String($0)}
    var d = d.map{String($0)}
    
    var i = 0
    var j = 0
    while i < s.count && j < d.count {
        if s[i] == d[j] {
            i += 1
            j += 1
        } else {
            i += 1
        }
    }
    
    return j == d.count
}

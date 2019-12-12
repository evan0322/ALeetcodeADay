//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//Bucket sort
func customSortString(_ S: String, _ T: String) -> String {
    var s = S.map{ String($0) }
    var t = T.map{ String($0) }
    
    var orders = [String:Int]()
    for i in 0..<s.count {
        orders[s[i]] = i
    }
    
    var bucket = Array(repeating:[String](), count:s.count)
    var other = [String]()
    
    for char in t {
        if let order = orders[char] {
            bucket[order] = bucket[order] + [char]
        } else {
            other.append(char)
        }
    }
    
    for b in bucket {
        if b.count != 0 {
            other = other + b
        }
    }
    
    return other.joined()
}

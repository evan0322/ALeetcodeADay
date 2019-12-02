//: [Previous](@previous)

import Foundation


//Fill 1, 3, 5... with most frequent char first, then the rest of the char can be filled in any order
func reorganizeString(_ S: String) -> String {
    guard S.count > 0 else {
        return ""
    }
    
    var s = S.map{ String($0) }
    var memo = [String:Int]()
    var maxChar = ""
    var maxCount = 0
    
    for char in s {
        if var count = memo[char] {
            count += 1
            if count > maxCount {
                maxCount = count
                maxChar = char
            }
            memo[char] = count
        } else {
            memo[char] = 1
        }
    }
    
    if maxCount > (s.count + 1)/2 {
        return ""
    }
    
    var resultArr = Array(repeating:"",count:s.count)
    
    
     var i = 0
     while memo.keys.count > 0 {
         var curChar = ""
         var count = 0
         if let topCount = memo[maxChar] {
             curChar = maxChar
             count = topCount
         } else {
             curChar = memo.keys.first!
             count = memo[curChar]!
         }
         count -= 1
         if count == 0 {
             memo[curChar] = nil
         } else {
             memo[curChar] = count
         }
         
         resultArr[i] = curChar
         
         i += 2
         if i%2 == 0 && i >= s.count {
             i = 1
         }
     }
                          
     return resultArr.joined()
                          
                          
                          
}

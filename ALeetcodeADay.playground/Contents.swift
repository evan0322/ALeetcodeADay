//: Playground - noun: a place where people can play

import UIKit

class Solution {
    
    // 14. Longest Common Prefix
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 0 else {
            return ""
        }
        var common = ""
        for i in 0...Int.max {
            guard let currentCommon = strs.first!.stringAtIndex(index: i) else {
                return common
            }
            for string in strs {
                if i >= string.count || string.stringAtIndex(index: i) != currentCommon {
                    return common
                }
            }
            common = common + currentCommon
            }
        return common
    }
    
    //Fasteest answer.
    //Instead of starting at the begin of the string then adding up, the function keep deleting the first string until all the string contains the
    //Trimed string
    /*
     func longestCommonPrefix(_ strs: [String]) -> String {
     
         guard !strs.isEmpty else {
             return ""
         }
         var prefix = strs[0]
         for index in 1..<strs.count {
             while !strs[index].hasPrefix(prefix) {
                 prefix = String(prefix.dropLast())
             }
         }
     
         return prefix
     }
 
     */
    

}

extension String {
    func stringAtIndex(index: Int) -> String? {
        guard index < self.count else {
            return nil
        }
        let stringArray = Array(self)
        return String(stringArray[index])
    }
}


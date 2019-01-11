//: [Previous](@previous)

import Foundation

//777. Swap Adjacent in LR String

/*
 In a string composed of 'L', 'R', and 'X' characters, like "RXXLRXRXL", a move consists of either replacing one occurrence of "XL" with "LX", or replacing one occurrence of "RX" with "XR". Given the starting string start and the ending string end, return True if and only if there exists a sequence of moves to transform one string to the other.
 
 Example:
 
 Input: start = "RXXLRXRXL", end = "XRLXXRRLX"
 Output: True
 Explanation:
 We can transform start to end following these steps:
 RXXLRXRXL ->
 XRXLRXRXL ->
 XRLXRXRXL ->
 XRLXXRRXL ->
 XRLXXRRLX
 Note:
 
 1 <= len(start) = len(end) <= 10000.
 Both start and end will only consist of characters in {'L', 'R', 'X'}.

 */

func canTransform(_ start: String, _ end: String) -> Bool {
    guard start.count > 0, start.count == end.count else {
        return false
    }
    
    var i = 0
    var j = 0
    
    var s = start.map{ String($0) }
    var e = end.map{ String($0) }
    while i < s.count && j < e.count {
        while i < s.count && s[i] == "X" {
            i += 1
        }
        
        while j < e.count && e[j] == "X" {
            j += 1
        }
        
        if i == s.count && j == e.count {
            return true
        } else if i == s.count || j == e.count {
            return false
        }
        
        if s[i] != e[j] {
            return false
        }
        
        if s[i] == "R" {
            if j < i {
                return false
            }
        }
        
        if s[i] == "L" {
            if j > i {
                return false
            }
        }
        
        i += 1
        j += 1
    }
    
    if i == s.count && j == e.count {
        return true
    } else {
        while i < s.count && s[i] == "X"  {
            i += 1
        }
        
        while j < e.count && e[j] == "X" {
            j += 1
        }
        
        return i == s.count && j == e.count
    }
}

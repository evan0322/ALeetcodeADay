//: [Previous](@previous)

import Foundation

/*
 301. Remove Invalid Parentheses
 We use bfs to go level by level. At each level, we remove any char in the string that is either "(" or ")", check if the string is visited before. If it has not, we remove one of the parenthese and put it in the queue to check if it is valid.
 Note that once we find a valid parenthese, we stop generating next level.
 */
func removeInvalidParentheses(_ s: String) -> [String] {
    guard s.count > 0 else {
        return [""]
    }
    
    var visited:Set<String> = Set()
    var queue = [String]()
    var result = [String]()
    var found = false
    
    queue.append(s)
    
    while queue.count != 0 {
        let s = queue.removeFirst()
        
        if isValidP(s:s) {
            result.append(s)
            found = true
        }
        
        if found {
            continue
        }
        var sArray = s.map{ String($0) }
        
        for i in 0..<sArray.count {
            if sArray[i] != "(" && sArray[i] != ")" {
                continue
            }
            let newString = (sArray[0..<i] + sArray[i + 1..<sArray.count]).joined()
            if !visited.contains(newString){
                queue.append(newString)
                visited.insert(newString)
            }
        }
    }
    
    return result
}

func isValidP(s:String) -> Bool {
    guard s.count > 0 else {
        return true
    }
    
    var count = 0
    for char in s {
        if char == "(" {
            count += 1
        } else if char == ")" {
            count -= 1
            if count < 0 {
                return false
            }
        }
    }
    return count == 0
}


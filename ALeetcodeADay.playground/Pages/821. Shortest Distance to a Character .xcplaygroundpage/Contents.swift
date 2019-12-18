//: [Previous](@previous)

import Foundation


//821. Shortest Distance to a Character
func shortestToChar(_ S: String, _ C: Character) -> [Int] {
    guard S.count > 0 else {
        return [Int]()
    }
    var c = String(C)
    var s = S.map{ String($0) }
    var sLoc = [Int]()
    var pointer = 0
    var result = [Int]()
    
    for i in 0..<s.count {
        if s[i] == c {
            sLoc.append(i)
        }
    }
    
    
    for i in 0..<s.count {
        if s[i] == c {
            pointer += 1
            result.append(0)
        } else {
            if pointer == 0 {
                result.append(sLoc[pointer] - i)
            } else if pointer == sLoc.count {
                result.append(i - sLoc[pointer - 1])
            } else {
                result.append(min(sLoc[pointer] - i, i - sLoc[pointer - 1]))
            }
        }
    }
    
    return result
}

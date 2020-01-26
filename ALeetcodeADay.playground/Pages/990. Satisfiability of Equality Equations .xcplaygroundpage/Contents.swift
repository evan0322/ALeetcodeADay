//: [Previous](@previous)

import Foundation

//If you can not do it in one pass, do it in two passes. The complexity is still O(n)
func equationsPossible(_ equations: [String]) -> Bool {
    guard equations.count > 0 else {
        return false
    }
    
    var ufs = UnionFindSet<String>()
            
    for equation in equations {
        if equation.contains("==") {
            var temp = equation.components(separatedBy:"==")
            let a = temp[0]
            let b = temp[1]
            if ufs.find(a) == nil {
                ufs.add(a)
            }
            
            if ufs.find(b) == nil {
                ufs.add(b)
            }
            ufs.union(a,b)
        }
    }
    
    for equation in equations {
        if equation.contains("!=") {
            var temp = equation.components(separatedBy:"!=")
            let a = temp[0]
            let b = temp[1]
            if a == b {
                return false
            }
            
            if let setA = ufs.find(a), let setB = ufs.find(b) {
                if setA == setB {
                    return false
                }
            }
        }
    }
    
    return true
    
}

//: [Previous](@previous)

import Foundation

func generateParenthesis(_ n: Int) -> [String] {
    var result = [String]()
    
    func generateP(current:[String], leftBalance:Int, rightBalance:Int) {
        guard current.count != 2 * n else {
            result.append(current.joined())
            return
        }
        
        if leftBalance > 0 {
            generateP(current:current + ["("], leftBalance:leftBalance - 1, rightBalance:rightBalance)
        }
        
        if rightBalance > 0 && rightBalance > leftBalance {
            generateP(current:current + [")"], leftBalance:leftBalance, rightBalance:rightBalance - 1)
        }
    }
    
    generateP(current:[String](), leftBalance:n, rightBalance:n)
    
    return result
}

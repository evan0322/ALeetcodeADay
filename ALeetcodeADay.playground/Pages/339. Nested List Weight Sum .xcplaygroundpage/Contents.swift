//: [Previous](@previous)

import Foundation

func depthSum(_ nestedList: [NestedInteger]) -> Int {
    var result = 0
    
    for nestedInteger in nestedList {
        result += sumNum(nestedInteger:nestedInteger, depth:1)
    }
    
    return result
}


func sumNum(nestedInteger:NestedInteger, depth: Int) -> Int {
    if nestedInteger.isInteger() {
        return depth * nestedInteger.getInteger()
    }
    
    let integerList = nestedInteger.getList()
    var total = 0
    
    for nInteger in integerList {
        total += sumNum(nestedInteger:nInteger, depth:depth + 1)
    }
    
    return total
}

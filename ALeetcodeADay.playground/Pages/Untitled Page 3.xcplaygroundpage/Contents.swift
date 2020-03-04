//: [Previous](@previous)

import Foundation

//1055. Shortest Way to Form String


//Scan target from left to right, if the char is equal to current char of source, we move both pointer forward, otherwise move pointer of the source until find a match. if the all char used in source, we get a new source and start from begining
func shortestWay(_ source: String, _ target: String) -> Int {
    let source = Array(source)
    let target = Array(target)
    
    let tSet = Set(source)
    
    for char in target {
        if !tSet.contains(char) {
            return -1
        }
    }
    
    var index = 0
    var count = 1
    
    for i in 0..<target.count {
        if index == source.count {
            index = 0
            count += 1
        }

        while target[i] != source[index] {
            index += 1
            if index == source.count {
                index = 0
                count += 1
            }
        }
        index += 1
    }
    
    return count
    
}

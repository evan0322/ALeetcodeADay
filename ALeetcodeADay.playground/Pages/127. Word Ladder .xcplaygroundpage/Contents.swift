//: [Previous](@previous)

import Foundation

/*
 "The idea behind bidirectional search is to run two simultaneous searches—one forward from
 the initial state and the other backward from the goal—hoping that the two searches meet in
 the middle. The motivation is that b^(d/2) + b^(d/2) is much less than b^d. b is branch factor, d is depth. "
 
 1. It's much faster than one-end search indeed as explained in wiki.
 2. BFS isn't equivalent to Queue. Sometimes Set is more accurate representation for nodes of level. (also handy since we need to check if we meet from two ends)
 3. It's safe to share a visited set for both ends since if they meet same string it terminates early. (vis is useful since we cannot remove word from dict due to bidirectional search)
 4. It seems like if(set.add()) is a little slower than if(!contains()) then add() but it's more concise.
 */

func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    guard wordList.contains(endWord) else {
        return 0
    }
    
    var count = 1
    
    let wordList = Set(wordList)
    
    let az = "abcdefghijklmnopqrstuvwxyz".map{String($0)}
    
    var beginSet = Set<String>()
    var endSet = Set<String>()
    
    var visited = Set<String>()
    
    beginSet.insert(beginWord)
    endSet.insert(endWord)
    
    while !beginSet.isEmpty && !endSet.isEmpty {
        if beginSet.count > endSet.count {
            let tmp = beginSet
            beginSet = endSet
            endSet = tmp
        }
        
        var temp = Set<String>()
        
        for word in beginSet {
            let chars = word.map{String($0)}
            for i in 0..<chars.count {
                for c in az {
                    if c == chars[i] {
                        continue
                    }
                    
                    let curChars = chars[0..<i] + [c] + chars[i + 1..<chars.count]
                    let curString = curChars.joined()
                    if endSet.contains(curString) {
                        return count + 1
                    }
                    
                    if !visited.contains(curString) && wordList.contains(curString) {
                        temp.insert(curString)
                        visited.insert(curString)
                    }
                }
            }
        }
        
        beginSet = temp
        count += 1
        
    }
    
    return 0
}

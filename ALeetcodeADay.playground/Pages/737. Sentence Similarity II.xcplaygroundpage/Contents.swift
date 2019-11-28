//: [Previous](@previous)

import Foundation

func areSentencesSimilarTwo(_ words1:[String], _ words2:[String],_ pairs:[[String]]) -> Bool {
    guard words1.count == words2.count else {
        return false
    }
    
    var unionFindSet = UnionFindSet<String>()
    
    for pair in pairs {
        if unionFindSet.findByElement(pair[0]) == nil {
            unionFindSet.addElement(pair[0])
        }
        
        if unionFindSet.findByElement(pair[1]) == nil {
            unionFindSet.addElement(pair[1])
        }
        
        unionFindSet.union(pair[0], pair[1])
    }
    
    for i in 0..<words1.count {
        if words1[i] == words2[i] {
            continue
        }
        
        if let set1 = unionFindSet.findByElement(words1[i]), let set2 = unionFindSet.findByElement(words2[i]) {
            if set1 != set2 {
                return false
            }
        } else {
            return false
        }
    }
    
    return true
}


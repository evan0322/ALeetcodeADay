//: [Previous](@previous)

import Foundation

func findCircleNum(_ M:[[Int]]) -> Int {
    guard M.count > 0 else {
        return 0
    }
    
    var unionFindSet = UnionFindSet<Int>()
    
    for i in 0..<M.count {
        for j in 0..<M[i].count {
            if M[i][j] == 1 {
                if unionFindSet.findByElement(i) == nil {
                    unionFindSet.addElement(i)
                }
                
                if unionFindSet.findByElement(j) == nil {
                    unionFindSet.addElement(j)
                }
                
                unionFindSet.union(i, j)
            }
        }
    }
    
    var memo = Set<Int>()
    
    for i in 0..<M.count {
        memo.insert(unionFindSet.findByElement(i)!)
    }
    
    return memo.count
}

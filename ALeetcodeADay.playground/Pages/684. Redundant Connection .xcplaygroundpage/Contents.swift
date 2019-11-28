//: [Previous](@previous)

import Foundation

func findRedundantConnection(_ edges:[[Int]]) -> [Int] {
    guard edges.count > 0 else {
        return [Int]()
    }
    
    var unionFindSet = UnionFindSet<Int>()
    
    for edge in edges {
        let firstEdge = edge[0]
        let secondEdge = edge[1]
        
        if
            let firstSet = unionFindSet.findByElement(firstEdge),
            let secondSet = unionFindSet.findByElement(secondEdge) {
            
            if firstSet == secondSet {
                return edge
            } else {
                unionFindSet.union(firstEdge, secondEdge)
            }
            
        } else {
            if unionFindSet.findByElement(firstEdge) == nil {
                unionFindSet.addElement(firstEdge)
            }
            
            if unionFindSet.findByElement(secondEdge) == nil {
                unionFindSet.addElement(secondEdge)
            }
            
            
            unionFindSet.union(firstEdge, secondEdge)
        }
    }
    
    return [Int]()
}


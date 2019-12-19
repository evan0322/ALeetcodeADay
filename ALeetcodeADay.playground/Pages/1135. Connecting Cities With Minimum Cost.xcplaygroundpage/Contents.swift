//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//Sort the cost of the edge. Then add the edge one by one. If we find a unconnected edge (ufs.find(n1) != ufs.find(n2)) we connect the nodes and add the cost, since there is no edge with lower cost that can connect these nodes.
struct UnionFindSet<T:Hashable> {
    var indexMap = [T:Int]()
    var parent = [Int]()
    public var size = [Int]()
    
    mutating func add(_ element:T) {
        indexMap[element] = parent.count
        parent.append(parent.count)
        size.append(1)
    }
    
    private mutating func findByIndex(_ index:Int) -> Int {
        if parent[index] == index {
            return parent[index]
        }
        
        parent[index] = findByIndex(parent[index])
        return parent[index]
    }
    
    mutating func find(_ element:T) -> Int? {
        if let index = indexMap[element] {
            return findByIndex(index)
        }
        
        return nil
    }
    
    mutating func union(_ fElement:T, _ sElement:T) {
        if let fIndex = self.find(fElement), let sIndex = self.find(sElement) {
            if size[fIndex] >= size[sIndex] {
                parent[sIndex] = fIndex
                size[fIndex] += size[sIndex]
            } else {
                parent[fIndex] = sIndex
                size[sIndex] += size[fIndex]
            }
        }
    }
}


func minimumCost(_ N: Int, _ connections: [[Int]]) -> Int {
    guard connections.count > 0 else {
        return -1
    }
    var cost = 0
    var connections = connections
    connections.sort{ $0[2] < $1[2] }
    
    
    var ufs = UnionFindSet<Int>()
    
    for connection in connections {
        
        if (ufs.find(connection[0]) == nil) {
            ufs.add(connection[0])
        }
        
        if (ufs.find(connection[1]) == nil) {
            ufs.add(connection[1])
        }
        
        if ufs.find(connection[0]) == ufs.find(connection[1]) {
            continue
        }
        
        ufs.union(connection[0], connection[1])
        cost += connection[2]
    }
    
    for size in ufs.size {
        if size == N {
            return cost
        }
    }
    
    return -1
}

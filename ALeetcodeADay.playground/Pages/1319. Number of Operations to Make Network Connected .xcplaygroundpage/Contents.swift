//: [Previous](@previous)

import Foundation

 struct UnionFindSet<T:Hashable>{
    var indexMap = [T:Int]()
    var parent = [Int]()
    var size = [Int]()
    
    mutating func add(_ element:T) {
        indexMap[element] = parent.count
        parent.append(parent.count)
        size.append(1)
    }
    
    mutating func findByIndex(_ index:Int) -> Int {
        if parent[index] == index {
            return parent[index]
        }
        
        parent[index] = findByIndex(parent[index])
        return parent[index]
    }
    
    mutating func find(_ element: T) -> Int? {
        guard let index = indexMap[element] else {
            return nil
        }
        
        return findByIndex(index)
    }
    
    mutating func union(_ element1:T,_ element2:T) {
        guard let index1 = find(element1), let index2 = find(element2) else {
            return
        }
        
        if index1 == index2 {
            return
        }
        
        if size[index1] >= size[index2] {
            parent[index2] = index1
            size[index1] += size[index2]
        } else {
            parent[index1] = index2
            size[index2] += size[index1]
        }
    }
}


func makeConnected(_ n: Int, _ connections: [[Int]]) -> Int {
    guard connections.count >= n - 1 else {
        return -1
    }
    
    var ufs = UnionFindSet<Int>()
    
    for connection in connections {
        if ufs.find(connection[0]) == nil {
            ufs.add(connection[0])
        }
        
        if ufs.find(connection[1]) == nil {
            ufs.add(connection[1])
        }
        
        ufs.union(connection[0], connection[1])
        
    }
    
    let missComponent = n - ufs.indexMap.count
    
    
    
    var set = Set<Int>()
    for i in 0..<n {
        if let index = ufs.find(i) {
            set.insert(index)
        }
    }
    //Isolated element + the total group - 1
    return missComponent + set.count - 1
}

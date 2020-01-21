
import Foundation

struct UnionFindSet<T: Hashable> {
    var indexMap = [T:Int]()
    var parent = [Int]()
    var size = [Int]()
    var count = 0
    
    mutating func add(_ element:T) {
        indexMap[element] = parent.count
        parent.append(parent.count)
        size.append(1)
        count += 1
    }
    
    mutating func findByIndex(_ index:Int) ->Int {
        if parent[index] == index {
            return parent[index]
        }
        
        parent[index] = findByIndex(parent[index])
        return parent[index]
    }
    
    mutating func find(_ element:T) -> Int? {
        guard let index = indexMap[element] else {
            return nil
        }
        
        return findByIndex(index)
    }
    
    mutating func union(_ first:T, _ second:T) {
        guard let fIndex = find(first), let sIndex = find(second) else {
            return
        }
        
        if fIndex == sIndex {
            return
        }
        
        if size[fIndex] >= size[sIndex] {
            parent[sIndex] = fIndex
            size[fIndex] += size[sIndex]
        } else {
            parent[fIndex] = sIndex
            size[sIndex] += size[fIndex]
        }
        count -= 1
    }
}

/*
 For each island we put on the map, we first add to the ufs, then check its surrounding. If we find any other island, union them.
 
 Note we need an extra parameter in the ufs to keep track of the total number of clusters we have so far.
 */
func numIslands2(_ m: Int, _ n: Int, _ positions: [[Int]]) -> [Int] {
    var ufs = UnionFindSet<String>()
    let dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    
    var result = [Int]()
    
    for position in positions {
        let i = position[0]
        let j = position[1]
        let str = "\(i),\(j)"
        
        if let index = ufs.find(str) {
            result.append(ufs.count)
            continue
        }
        
        ufs.add(str)
        
        for dir in dirs {
            let a = i + dir[0]
            let b = j + dir[1]
            let newStr = "\(a),\(b)"
            
            if a < 0 || a >= m || b < 0 || b >= n {
                continue
            }
            
            if let index = ufs.find(newStr) {
                ufs.union(str,newStr)
            }
        }
        
        result.append(ufs.count)
    }
    
    return result
}


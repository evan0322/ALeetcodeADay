//: [Previous](@previous)

import Foundation

struct UnionFindSet<T:Hashable> {
    private var indexDict = [T:Int]()
    private var parent = [Int]()
    var size = [Int]()
    
    mutating public func add(_ element:T) {
        indexDict[element] = parent.count
        parent.append(parent.count)
        size.append(1)
    }
    
    mutating public func findSetByIndex(_ index:Int) -> Int{
         if parent[index] == index {
             return index
         }
        
        parent[index] = findSetByIndex(parent[index])
        return parent[index]
    }
    
    mutating public func findSetByElement(_ element:T) -> Int? {
        guard let index = self.indexDict[element] else {
            return nil
        }
        
        return self.findSetByIndex(index)
    }
    
    mutating public func union(_ firstElement:T, _ secondElement:T) {
        if let fIndex = self.findSetByElement(firstElement), let sIndex = self.findSetByElement(secondElement) {
            if size[fIndex] >= size[sIndex] {
                parent[sIndex] = parent[fIndex]
                size[fIndex] = size[fIndex] + size[sIndex]
            }  else {
                parent[fIndex] = parent[sIndex]
                size[sIndex] = size[fIndex] + size[sIndex]
            }
        }
    }
    
}

//Use hash map to record is which value belongs which index (duplicate does not count). Use union find to union all index with value - 1 and value + 1.
func longestConsecutive(_ nums: [Int]) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    
    var ufs = UnionFindSet<Int>()
    
    var memo = [Int:Int]() //value : index
    
    for i in 0..<nums.count {
        if memo[nums[i]] != nil {
            continue
        }
        
        memo[nums[i]] = i
        ufs.add(i)
        
        if let left = memo[nums[i] - 1] {
            ufs.union(left,i)
        }
        
        if let right = memo[nums[i] + 1] {
            ufs.union(right,i)
        }
    }
    
    var maxCount = 0
    
    for s in ufs.size{
        maxCount = max(maxCount, s)
    }
    
    return maxCount
}

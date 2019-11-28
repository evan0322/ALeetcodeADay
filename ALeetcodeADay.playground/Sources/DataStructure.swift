import Foundation

public class UnionFindSet<T: Hashable> {
     var index = [T:Int]()
     var parent = [Int]()
     var size = [Int]()
    
    
    public func addSetWith(_ element:T) {
        self.index[element] = self.parent.count
        self.parent.append(parent.count)
        self.size.append(1)
    }
    
    public func findSetByIndex(_ index:Int) -> Int {
        if index != parent[index] {
            parent[index] = self.findSetByIndex(parent[index])
        }
        
        return parent[index]
    }
    
    public func findSetByElement(_ element:T) -> Int? {
        guard let i = self.index[element] else {
            return nil
        }
        
        return self.findSetByIndex(i)
    }
    
    public func union(_ firstElement:T, secondElement:T) {
        if
            let firstSet = self.findSetByElement(firstElement),
            let secondSet = self.findSetByElement(secondElement) {
            if firstSet != secondSet {
                if self.size[firstSet] < self.size[secondSet] {
                    parent[firstSet] = secondSet
                    size[secondSet] += size[firstSet]
                } else {
                    parent[secondSet] = firstSet
                    size[firstSet] += size[secondSet]
                }
            }
        }
    }
}

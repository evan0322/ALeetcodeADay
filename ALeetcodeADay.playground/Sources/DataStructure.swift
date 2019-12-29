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

public class ListNode: CustomStringConvertible {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    public var description: String {
        var des = "\(self.val)"
        var next = self.next
        
        while next != nil {
            des += "->\(next!.val)"
            next = next!.next
        }
        
        return des
    }
    
    public class func createListNode(_ values:[Int]) -> ListNode {
        let dummy = ListNode(-1)
        var head = dummy
        for val in values {
            let node = ListNode(val)
            head.next = node
            head = head.next!
        }
        
        return dummy.next ?? ListNode(-1)
    }
}

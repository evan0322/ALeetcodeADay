import Foundation

struct UnionFindSet<T: Hashable> {
    private var indexMap = [T:Int]()
    private var parent = [Int]()
    private var size = [Int]()
    private var count = 0
    
    mutating func add(_ element:T) {
        indexMap[element] = parent.count
        parent.append(parent.count)
        size.append(1)
        count += 1
    }
    
    internal mutating func findByIndex(_ index:Int) ->Int {
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

public class DoubleListNode: CustomStringConvertible {
    public var val: Int
    public var next: DoubleListNode?
    public var pre: DoubleListNode?
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

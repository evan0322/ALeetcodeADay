import Foundation

struct PriorityQueue<Element>
{
    var elements : [Element]
    let priorityFunction : (Element, Element) -> Bool
    
    init(elements: [Element] = [], priorityFunction: @escaping (Element, Element) -> Bool) {
        self.elements = elements
        self.priorityFunction = priorityFunction
        buildHeap()
    }
    
    mutating func buildHeap() {
        for index in (0 ..< count / 2).reversed() {
            siftDown(elementAtIndex: index)
        }
    }
    
    var isEmpty : Bool { return elements.isEmpty }
    var count : Int { return elements.count }
    
    func peek() -> Element? {
        return elements.first
    }
    
    mutating func enqueue(_ element: Element) {
        elements.append(element)
        siftUp(elementAtIndex: count - 1)
    }
    
    mutating func siftUp(elementAtIndex index: Int) {
        let parent = parentIndex(of: index)
        guard !isRoot(index),
            isHigherPriority(at: index, than: parent)
            else { return }
        swapElement(at: index, with: parent)
        siftUp(elementAtIndex: parent)
    }
    
    mutating func dequeue() -> Element? {
        guard !isEmpty
            else { return nil }
        swapElement(at: 0, with: count - 1)
        let element = elements.removeLast()
        if !isEmpty {
            siftDown(elementAtIndex: 0)
        }
        return element
    }
    
    mutating func siftDown(elementAtIndex index: Int) {
        let childIndex = highestPriorityIndex(for: index)
        if index == childIndex {
            return
        }
        swapElement(at: index, with: childIndex)
        siftDown(elementAtIndex: childIndex)
    }
    
    // Helper functions
    
    func isRoot(_ index: Int) -> Bool {
        return index == 0
    }
    
    func leftChildIndex(of index: Int) -> Int {
        return (2 * index) + 1
    }
    
    func rightChildIndex(of index: Int) -> Int {
        return (2 * index) + 2
    }
    
    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return priorityFunction(elements[firstIndex], elements[secondIndex])
    }
    
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        guard childIndex < count && isHigherPriority(at: childIndex, than: parentIndex)
            else { return parentIndex }
        return childIndex
    }
    
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent, and: leftChildIndex(of: parent)), and: rightChildIndex(of: parent))
    }
    
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex
            else { return }
        elements.swapAt(firstIndex, secondIndex)
    }
}


public class PriorityQueueSimple<Element> {
    var elements: [Element]
    var priorityFunction: (Element, Element) -> Bool
    var count: Int { return elements.count }
    
    init(priorityFunction:@escaping (Element, Element) -> Bool) {
        self.elements = [Element]()
        self.priorityFunction = priorityFunction
    }
    
    func isHigherPriority(at index:Int,than secondIndex:Int) -> Bool {
        return self.priorityFunction(elements[index], elements[secondIndex])
    }
    
    func enqueue(element:Element) {
        elements.append(element)
        siftUp(index: elements.count - 1)
    }
    
    func dequeue() -> Element? {
        if elements.count == 0 {
            return nil
        }
        
        elements.swapAt(0, elements.count - 1)
        let element = elements.removeLast()
        siftDown(index: 0)
        return element
    }
    
    func peek() -> Element? {
        return elements.last
    }
    
    func siftUp(index:Int) {
        if index == 0 {
            return
        }
        
        let parent = parentIndex(for: index)
        if isHigherPriority(at: index, than: parent) {
            elements.swapAt(index, parent)
            siftUp(index: parent)
        }
    }
    
    func siftDown(index:Int) {
        var highIndex = index
        let leftIndex = leftChildIndex(for: index)
        let rightIndex = rightChildIndex(for: index)
        if leftIndex < count && isHigherPriority(at: leftIndex, than: index) {
            highIndex = leftIndex
        }
        if rightIndex < count && isHigherPriority(at: rightIndex, than: highIndex) {
            highIndex = rightIndex
        }
        if highIndex == index {
            return
        } else {
            elements.swapAt(highIndex, index)
            siftDown(index: highIndex)
        }
    }
    
    func parentIndex(for index:Int) -> Int {
        return (index - 1)/2
    }
    
    func leftChildIndex(for index:Int) -> Int {
        return index * 2 + 1
    }
    
    func rightChildIndex(for index:Int) -> Int {
        return index * 2 + 2
    }

var heap = PriorityQueue<Int>(elements: [3, 2, 8, 5, 0], priorityFunction: >)
heap.enqueue(6)
heap.enqueue(1)
heap.enqueue(4)
heap.enqueue(7)
heap.dequeue()
print(heap.elements)


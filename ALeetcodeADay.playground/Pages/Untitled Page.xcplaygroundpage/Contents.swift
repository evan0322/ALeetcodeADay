//: [Previous](@previous)

import Foundation

//Use priority Queue
//295. Find Median from Data Stream
class MedianFinder {
    //Holds the small part of the stream but track the largest one
    let maxQueue: PriorityQueue<Int>
    //Holds the larger part of the stream but track the smallest one
    let minQueue: PriorityQueue<Int>
    /** initialize your data structure here. */
    init() {
        maxQueue = PriorityQueue<Int>(priorityFunction:{ $0 > $1 })
        minQueue = PriorityQueue<Int>(priorityFunction:{ $0 < $1 })
    }
    
    func addNum(_ num: Int) {
        maxQueue.enqueue(num)
        if let num = maxQueue.dequeue() {
            minQueue.enqueue(num)
            if maxQueue.count < minQueue.count {
                if let minNum = minQueue.dequeue() {
                    maxQueue.enqueue(minNum)
                }
            }
        }
    }
    
    func findMedian() -> Double {
        if maxQueue.count == minQueue.count {
            return (Double(maxQueue.peek()!) + Double(minQueue.peek()!)) / 2
        } else {
            return Double(maxQueue.peek()!)
        }
    }
}

/**
 * Your MedianFinder object will be instantiated and called as such:
 * let obj = MedianFinder()
 * obj.addNum(num)
 * let ret_2: Double = obj.findMedian()
 */


public class PriorityQueue<Element> {
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
    
    func enqueue(_ element:Element) {
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
        return elements.first
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
}

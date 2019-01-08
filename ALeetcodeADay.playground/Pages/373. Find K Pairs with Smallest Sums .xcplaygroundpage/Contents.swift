//: [Previous](@previous)

import Foundation

//373. Find K Pairs with Smallest Sums
class Solution {
    //Use priority queue
    func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        guard k > 0, nums1.count > 0, nums2.count > 0  else {
            return [[Int]]()
        }
        
        let pq = PriorityQueue<Pair>(priorityFunction:{(p1, p2) in
            return p1.sum < p2.sum
        })
        
        var result = [[Int]]()
        
        for j in 0..<nums2.count {
            let pair = Pair(i:0, j:j, sum:nums1[0] + nums2[j])
            pq.enqueue(element:pair)
        }
        
        
        
        
        for i in 0..<min(k, nums1.count * nums2.count) {
            if let cur = pq.dequeue() {
                result.append([nums1[cur.i], nums2[cur.j]])
                if cur.i == nums1.count - 1 {
                    continue
                }
                let pair = Pair(i:cur.i + 1, j:cur.j, sum:nums1[cur.i + 1] + nums2[cur.j])
                pq.enqueue(element:pair)
            }
        }
        
        return result
    }
}

class Pair {
    let i: Int
    let j: Int
    let sum: Int
    init(i:Int, j:Int, sum:Int) {
        self.i = i
        self.j = j
        self.sum = sum
    }
}


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
}

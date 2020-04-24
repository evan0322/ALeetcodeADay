//: [Previous](@previous)

import Foundation

//284. Peeking Iterator
class PeekingIterator {
  var element:IndexingIterator<Array<Int>>
    var cache: Int?
    
    init(_ arr: IndexingIterator<Array<Int>>) {
        self.element = arr
    }
    
    func next() -> Int {
        if let nextElement = cache {
            cache = nil
            return nextElement
        } else if let nextElement = element.next() {
            return nextElement
        } else {
            return -1
        }
    }
    
    func peek() -> Int {
        if let peekNum = cache {
            return peekNum
        } else {
            if let peekNum = element.next() {
                cache = peekNum
                return peekNum
            } else {
                return -1
            }
        }
    }
    
    func hasNext() -> Bool {
        if cache != nil {
            return true
        } else {
            if let nextNum = element.next() {
                cache = nextNum
                return true
            } else {
                return false
            }
        }
    }
}

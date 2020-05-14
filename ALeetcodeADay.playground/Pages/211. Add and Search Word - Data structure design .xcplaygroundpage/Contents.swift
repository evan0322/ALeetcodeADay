//: [Previous](@previous)

import Foundation


class WordDictionary {
    let head: TrieNode

    /** Initialize your data structure here. */
    init() {
        self.head = TrieNode("*")
    }
    
    /** Adds a word into the data structure. */
    func addWord(_ word: String) {
        let word = word.map{String($0)}
        var cur = self.head
        
        for char in word {
            if let node = cur.neighb[char] {
                cur = node
            } else {
                let newNode = TrieNode(char)
                cur.neighb[char] = newNode
                cur = newNode
            }
        }
        
        cur.isEnd = true
    }
    
    /** Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter. */
    func search(_ word: String) -> Bool {
        guard word.count > 0 else {
            return true
        }
        let word = word.map{String($0)}
        
        var stack = [self.head]
        
        for (index,char) in word.enumerated() {
            var newStack = [TrieNode]()
            
            for trieNode in stack {
                if char == "." {
                    newStack += Array(trieNode.neighb.values)
                } else {
                    if let node = trieNode.neighb[char] {
                        newStack.append(node)
                    }
                }
            }
            stack = newStack
            if stack.count == 0 {
                return false
            }
        }
        
        for node in stack {
            if node.isEnd {
                return true
            }
        }
        
        return false
    }
}

/**
 * Your WordDictionary object will be instantiated and called as such:
 * let obj = WordDictionary()
 * obj.addWord(word)
 * let ret_2: Bool = obj.search(word)
 */

class TrieNode {
    var val: String
    var neighb: [String:TrieNode]
    var isEnd: Bool
    
    init(_ val:String) {
        self.val = val
        self.neighb = [String:TrieNode]()
        self.isEnd = false
    }
}

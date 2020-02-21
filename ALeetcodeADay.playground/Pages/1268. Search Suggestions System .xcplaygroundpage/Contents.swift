//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

/*
 1. If we add the word in sorted order, we do not need to sort it when take it out.
 2. Only add the word if the trie node's words are less than 3
 Complexity depends on the sorting, the process of building Trie and the length of searchWord. Sorting cost O(m * n * logn), due to involving comparing String, which cost time O(m) for each comparison, building Trie cost O(m * n). Therefore,
 Time: O(m * n * logn + L), space: O(m * n + L * m)
 */
func suggestedProducts(_ products: [String], _ searchWord: String) -> [[String]] {
    var head = Trie("*")
    var products = products
    products.sort(by:<)
    
    print(products)
    
    for product in products {
        var cur = head
        
        for char in product {
            if let node = cur.children[char] {
                if node.words.count < 3 {
                    node.words.append(product)
                }
                cur = node
            } else {
                var node = Trie(char)
                node.words.append(product)
                cur.children[char] = node
                cur = node
            }
        }
    }
    
    var result = [[String]]()
    
    var cur = head
    var notFound = false
    
    for char in searchWord {
        if let node = cur.children[char] , notFound == false {
            result.append(node.words)
            cur = node
        } else {
            notFound = true
            result.append([String]())
        }
    }
    
    return result
    
}

class Trie {
    var value: Character
    var children: [Character:Trie]
    var words: [String]
    
    init(_ value:Character) {
        self.value = value
        self.children = [Character:Trie]()
        self.words = [String]()
    }
}

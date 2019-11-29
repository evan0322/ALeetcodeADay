//: [Previous](@previous)

import Foundation

func alienOrder(_ words:[String]) -> String  {
    guard words.count > 1 else {
        return ""
    }
    
    var orders = [String:Set<String>]()
    var degrees = [String:Int]()
    for word in words {
        for char in word {
            degrees[String(char)] = 0
        }
    }
    
    for i in 1..<words.count {
        let word1 = words[i - 1].map{String($0)}
        let word2 = words[i].map{String($0)}
                    
        for j in 0..<min(word1.count, word2.count) {
            
            if word1[j] != word2[j] {
                if var order = orders[word1[j]] {
                    if !order.contains(word2[j]) {
                        order.insert(word2[j])
                        orders[word1[j]] = order
                        degrees[word2[j]] = degrees[word2[j], default: 0] + 1
                    }
                } else {
                    orders[word1[j]] = Set([word2[j]])
                    degrees[word2[j]] = degrees[word2[j], default: 0] + 1
                }
                break
                
            }
        }
    }
    
    //Topoligical sort
    var queue = [String]()
    
    for (key, value) in degrees {
        if value == 0 {
            queue.append(key)
        }
    }
    //
    //    print(orders)
    //    print(degrees)
    //    print(queue)
    
    var result = [String]()
    var visited = Set<String>()
    
    while queue.count > 0 {
        let root = queue.removeFirst()
        result.append(root)
        visited.insert(root)
        if let nodes = orders[root] {
            for node in nodes {
                if visited.contains(node) {
                    continue
                }
                
                let degree = degrees[node]!
                degrees[node] = degree - 1
                
                if degrees[node] == 0 {
                    queue.append(node)
                }
            }
        }
    }
    
    if visited.count != degrees.count {
        return ""
    }
    
    
    return result.joined()
}

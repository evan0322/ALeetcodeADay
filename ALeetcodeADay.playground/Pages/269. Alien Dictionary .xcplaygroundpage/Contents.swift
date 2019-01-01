//: [Previous](@previous)

import Foundation
//269. Alien Dictionary

/*
 Use bfs, keep removing the node that has degree of 0, meanwhile decrease the degree of the node that depends on this node, if degree becomes 0, put it in the queue. Keep doing this until the queue is empty
 */
func alienOrder(_ words: [String]) -> String {
    guard words.count > 0 else {
        return ""
    }
    
    guard words.count > 1 else {
        return words[0]
    }
    
    var graph = [String:Set<String>]()
    var degree = [String:Int]()
    var result = ""
    
    func buildGraph(w1: String, w2: String) {
        guard w1.count > 0, w2.count > 0 else {
            return
        }
        
        var w1 = w1.map{ String($0) }
        var w2 = w2.map{ String($0) }
        
        var i = 0
        while i < w1.count && i < w2.count {
            if degree[w1[i]] == nil {
                degree[w1[i]] = 0
            }
            
            if degree[w2[i]] == nil {
                degree[w2[i]] = 0
            }
            if w1[i] != w2[i] {
                if var neighbs = graph[w2[i]] {
                    if !neighbs.contains(w1[i]) {
                        degree[w1[i]] = degree[w1[i], default:0] + 1
                    }
                    neighbs.insert(w1[i])
                    graph[w2[i]] = neighbs
                } else {
                    graph[w2[i]] = Set([w1[i]])
                    degree[w1[i]] = degree[w1[i], default:0] + 1
                }
                break
            }
            i += 1
        }
        
        var m = i
        var n = i
        
        while m < w1.count {
            if degree[w1[m]] == nil {
                degree[w1[m]] = 0
            }
            m += 1
        }
        while n < w2.count {
            if degree[w2[n]] == nil {
                degree[w2[n]] = 0
            }
            n += 1
        }
    }
    
    for i in 0..<words.count - 1 {
        buildGraph(w1: words[i], w2: words[i + 1])
    }
    
    
    
    var queue = [String]()
    
    for key in degree.keys {
        if degree[key] == 0 {
            queue.append(key)
        }
    }
    
    while queue.count > 0 {
        let cur = queue.removeFirst()
        result += cur
        if let neighbs = graph[cur] {
            for ne in neighbs {
                if let de = degree[ne] {
                    degree[ne] = de - 1
                    if de - 1 == 0 {
                        queue.append(ne)
                    }
                }
            }
        }
    }
    
    
    if result.count != degree.keys.count {
        return ""
    }
    
    return String(result.reversed())
}

//: [Previous](@previous)

import Foundation

func findJudge(_ N: Int, _ trust: [[Int]]) -> Int {
    if N == 1 && trust.count == 0 {
        return 1
    } else if N == 0 || trust.count == 0 {
        return -1
    }
    
    
    var graph = [Int:[Int]]()
    var degree = Array(repeating:0,count:N + 1)
    var candidates = [Int]()
    
    
    for i in 0..<trust.count {
        graph[trust[i][0]] = graph[trust[i][0], default:[Int]()] + [trust[i][1]]
        degree[trust[i][1]] += 1
        if degree[trust[i][1]] == N - 1 {
            candidates.append(trust[i][1])
        }
    }
    
    for can in candidates {
        if graph[can] == nil {
            return can
        }
    }
    
    return -1
    
}

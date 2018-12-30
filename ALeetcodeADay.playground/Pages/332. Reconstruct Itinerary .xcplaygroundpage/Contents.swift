//: [Previous](@previous)

import Foundation

//332. Reconstruct Itinerary
/*
 Based on the description, we need to achive 2 things:
 1. Fine a path that traverse all destinations
 2. when choose the path, always choose the one with smaller lexical order
 
 Use dfs, we
 can find a path that traverse all dests. now consider the point 2. We need to first sort the destination based on lexical order, then try dfs the first neigb, if it leads to an dead end, then we go back and choose the second priority one. Until all destination are visited.
 Note here we also need to kee track of the path that has been visited so that we do not go in loop
 
 Time complexity O(m + n) * O(logn): m is the num of different destinations, and n is the
 */


func findItinerary(_ tickets: [[String]]) -> [String] {
    guard tickets.count > 0 else {
        return [String]()
    }
    
    var results = [String]()
    var graph = [String:[String]]()
    
    for t in tickets {
        graph[t[0]] = graph[t[0], default:[String]()] + [t[1]]
    }
    
    for key in graph.keys {
        let nes = graph[key]!
        graph[key] = nes.sorted(by:<)
    }
    
    func dfs(cur:String, visited:[String:Bool], cPath:[String]) -> Bool {
        let cPath = cPath +  [cur]
        print("Travesing \(cPath)")
        
        if cPath.count == tickets.count + 1 {
            results = cPath
            return true
        }
        if let neighbs = graph[cur] {
            for i in 0..<neighbs.count {
                if visited["\(cur):\(i)"] == true {
                    continue
                }
                
                var nVisited = visited
                nVisited["\(cur):\(i)"] = true
                if dfs(cur:neighbs[i], visited:nVisited, cPath:cPath) {
                    return true
                }
            }
        }
        
        return false
    }
    
    dfs(cur:"JFK", visited:[String:Bool](), cPath:[String]())
    
    return results
}

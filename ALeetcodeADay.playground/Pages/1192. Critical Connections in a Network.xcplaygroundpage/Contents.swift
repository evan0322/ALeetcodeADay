//: [Previous](@previous)

import Foundation
/*
 Tarjan's algorithm
 1. Traverse the graph, mark the node with ids.
 2. Define lows[i] as the lowest id can be found if traverse from node i onwards
 3. Assume we have node with id j, and the the neighbor i. If ids[j] < lows[i] then we found a critial connection.
 (Translate: Node i cannot circle back to the coponent that contains of j, otherwise i will have smaller or equal lows[i] than ids[j])


 */
func criticalConnections(_ n: Int, _ connections: [[Int]]) -> [[Int]] {
     var visited = Array(repeating:false, count:n)
     var lows = Array(repeating:-1, count:n)
     var ids = Array(repeating:-1, count:n)
     
     var bridges = [[Int]]()
     
     var graph = [Int:[Int]]()
     
     for connection in connections {
         graph[connection[0]] = graph[connection[0], default:[Int]()] + [connection[1]]
         graph[connection[1]] = graph[connection[1], default:[Int]()] + [connection[0]]
     }
     var curId = -1
     
     func dfs(cur:Int, parent:Int) {
         visited[cur] = true
         curId += 1
         ids[cur] = curId
         lows[cur] =  curId
         if let neighbs = graph[cur] {
             for neighb in neighbs {
                 if neighb == parent {
                     continue
                 }
                 
                 if !visited[neighb] {
                     dfs(cur:neighb, parent:cur)
                     lows[cur] = min(lows[cur], lows[neighb])
                     if ids[cur] < lows[neighb] {
                         bridges.append([cur, neighb])
                     }
                 } else {
                     lows[cur] = min(lows[cur], ids[neighb])
                 }
             }
         }
     }
     

     
     dfs(cur:0, parent:-1)
     print(lows)
     return bridges
 }

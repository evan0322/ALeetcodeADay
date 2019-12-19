//: [Previous](@previous)

import Foundation

func canVisitAllRooms(_ rooms: [[Int]]) -> Bool {
    //Only visit each room once
    //O(Vertex + Edge) time complexity
    //O(n) space complexity (visited)
    guard rooms.count > 0 else {
        return true
    }
    
    
    var visited = Set<Int>()
    
    func dfs(room:Int) {
        if visited.contains(room) {
            return
        }
        
        visited.insert(room)
        
        let keys = rooms[room]
        
        for key in keys {
            dfs(room:key)
        }
    }
    
    dfs(room:0)
    
    return visited.count == rooms.count
    
}

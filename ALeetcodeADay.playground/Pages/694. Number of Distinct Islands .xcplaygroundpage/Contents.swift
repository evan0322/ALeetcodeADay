//: [Previous](@previous)

import Foundation

//694. Number of Distinct Islands
//The difference between this and num of islands is that we need to track the shape of the island by keep adding the path while dfs the island.
func numDistinctIslands(_ grid: [[Int]]) -> Int {
    guard grid.count > 0, grid[0].count > 0 else {
        return 0
    }
    
    typealias Dir = (Int, Int, String)
    
    var dirs = [Dir(0,1,"u"),
                Dir(1,0,"r"),
                Dir(0,-1,"d"),
                Dir(-1,0,"l")]
    
    
    var result = 0
    var visited = [[Bool]](repeating:[Bool](repeating:false,count:grid[0].count),count:grid.count)
    var memo = [String:Bool]()
    var path = ""
    
    func dfs(i:Int, j:Int, mark:String) {
        if i < 0 || j < 0 || i >= grid.count || j >= grid[0].count || grid[i][j] == 0 || visited[i][j] == true {
            return
        }
        
        visited[i][j] = true
        
        path += mark
        
        for dir in dirs {
            dfs(i:i + dir.0,j: j + dir.1, mark:dir.2)
        }
        
        //This is very important otherwise error in some rare use case
        path += "b"
    }
    
    for i in 0..<grid.count {
        for j in 0..<grid[0].count {
            if grid[i][j] != 0 && visited[i][j] == false {
                path = ""
                dfs(i:i, j:j, mark:"o")
                if path == "" || memo[path] == true {
                    continue
                } else {
                    result += 1
                    memo[path] = true
                }
            }
        }
    }
    
    return result
}

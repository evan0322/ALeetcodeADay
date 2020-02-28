//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


/*
 Find the first island and mark all lands as -1
 From all lands of the first island, do bfs to find the closest land from second island
 */
func shortestBridge(_ A: [[Int]]) -> Int {
    
    var dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    var lands = [[Int]]()
    var count = 0
    var A = A
    
    func dfs(i:Int, j:Int) {
        guard i >= 0, j >= 0, i < A.count, j < A[0].count, A[i][j] == 1 else {
            return
        }
        
        A[i][j] = -1
        lands.append([i, j])
        for dir in dirs {
            dfs(i:i + dir[0], j:j + dir[1])
        }
    }
    
    func bfsOnce(curLands:[[Int]]) -> Bool {
        var nextLands = [[Int]]()
        for land in curLands {
            for dir in dirs {
                let i = land[0] + dir[0]
                let j = land[1] + dir[1]
                
                if i < 0 || j < 0 || i >= A.count || j >= A[0].count || A[i][j] == -1 {
                    continue
                }
                
                if A[i][j] == 1 {
                    return true
                }
                A[i][j] = -1
                nextLands.append([i, j])
            }
        }
        lands = nextLands
        count += 1
        return false
    }
    
    var found = false
    for i in 0..<A.count {
        for j in 0..<A[i].count {
            if A[i][j] == 1 {
                dfs(i:i, j:j)
                found = true
                break
            }
        }
        if found {
            break
        }
    }
    
    
    while lands.count != 0 {
        let found = bfsOnce(curLands:lands)
        if found {
            return count
        }
    }
    
    return 0
    
}





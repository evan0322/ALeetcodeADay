//: [Previous](@previous)

import Foundation

//947. Most Stones Removed with Same Row or Column
//This question give us a tip about how to remember 2 dimentional coordinate is visited
// use a string "row * col" to mark a node, put it in [String:Bool]()
func removeStones(_ stones: [[Int]]) -> Int {
    guard stones.count > 0 else {
        return 0
    }
    
    var rMemo = [Int:[Int]]()
    var cMemo = [Int:[Int]]()
    var islands = 0
    
    var visited = [String:Bool]()
    
    for s in stones {
        rMemo[s[0]] = rMemo[s[0], default:[Int]()] + [s[1]]
        cMemo[s[1]] = cMemo[s[1], default:[Int]()] + [s[0]]
    }
    
    
    func dfs(row:Int, col:Int) {
        guard let cols = rMemo[row], let rows = cMemo[col] else {
            return
        }
        
        for c in cols {
            let key = "\(row)*\(c)"
            if visited[key] != nil {
                continue
            }
            
            visited[key] = true
            dfs(row: row, col: c)
        }
        
        for r in rows {
            let key = "\(r)*\(col)"
            if visited[key] != nil {
                continue
            }
            
            visited[key] = true
            dfs(row: r, col: col)
        }
    }
    
    for s in stones {
        let key = "\(s[0])*\(s[1])"
        if visited[key] == nil {
            islands += 1
            dfs(row: s[0], col: s[1])
        }
    }
    
    return stones.count - islands
}

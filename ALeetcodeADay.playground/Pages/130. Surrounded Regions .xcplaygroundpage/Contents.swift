
import Foundation
//Traverse from the edge of the graph
//Trade off: If we do not want to use extra space we can do it with multiple passes
func solve(_ board: inout [[Character]]) {
    guard board.count > 0 else {
        return
    }
    
    var newBoard = [[Character]](repeating:[Character](repeating:"X",count:board[0].count), count:board.count)
    
    var dirs = [[0, 1],
                [1,0],
                [0, -1],
                [-1, 0]]
    
    
    func dfs(i:Int, j:Int) {
        if i < 0 || j < 0 || i >= board.count || j >= board[0].count || board[i][j] == "X" || newBoard[i][j] == "O" {
            return
        }
        newBoard[i][j] = "O"
        for dir in dirs {
            dfs(i:i + dir[0], j: j + dir[1])
        }
    }
    
    for i in 0..<board.count {
        dfs(i:i, j:0)
        dfs(i:i, j:board[0].count - 1)
    }
    
    for j in 0..<board[0].count {
        dfs(i:0, j:j)
        dfs(i:board.count - 1, j:j)
    }
    board = newBoard
}

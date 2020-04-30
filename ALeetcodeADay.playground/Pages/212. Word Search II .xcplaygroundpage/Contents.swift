//: [Previous](@previous)

import Foundation


//212. Word Search II
func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
    
    let head = TrieNode("*")
    
    //Build Trie
    for word in words {
        var cur = head
        
        for char in word {
            if let neighb =  cur.neighb[char] {
                cur = neighb
            } else {
                let newNode = TrieNode(char)
                cur.neighb[char] = newNode
                cur = newNode
            }
        }
        
        cur.word = word
    }
    
    var result = Set<String>()
    
    
    func dfs(i:Int, j:Int, memo:[[Bool]], trie:TrieNode) {
        if i < 0 || j < 0 || i >= board.count || j >= board[i].count || memo[i][j] == true {
            return
        }
        
        let dirs = [[0,1], [1,0], [-1, 0], [0, -1]]
        var memo = memo
        memo[i][j] = true
        
        
        
        let char = board[i][j]
        if let neighb = trie.neighb[char] {
            if let endWord = neighb.word {
                result.insert(endWord)
            }
            for dir in dirs {
                dfs(i:i + dir[0], j:j + dir[1], memo:memo, trie:neighb)
            }
        }
    }
    for i in 0..<board.count {
        for j in 0..<board[i].count {
            let memo = Array(repeating:Array(repeating:false, count:board[i].count), count:board.count)
            dfs(i:i, j:j, memo:memo, trie:head)
        }
    }
    
    return Array(result)
}



class TrieNode {
    let value: Character
    var neighb: [Character:TrieNode]
    var word:String?
    
    init(_ value:Character) {
        self.value = value
        self.neighb = [Character:TrieNode]()
    }
}

//: [Previous](@previous)

import Foundation

/*
 Naturelly we should use trie to solve this problem

 We travel through the trie until the paths only have one element left.
 
 Note:
 1. Use dictionary to store the children of a trie node
 2. Path sainity check
 3. Trie MUST be class in order to keep reference
 */


class FileSystem {
    var trie: Trie

    init() {
        self.trie = Trie(value: -1, children: [String:Trie]())
    }

    func createPath(_ path: String, _ value: Int) -> Bool {
        var paths = path.components(separatedBy: "/")
        if paths.count <= 1 || paths.first != "" || paths.last! == "" {
            return false
        }

        var trie = self.trie
        paths.removeFirst()

        while paths.count > 1 {
            let curPath = paths.removeFirst()
            if curPath == "" {
                return false
            }
            guard let next = trie.children[curPath] else {
                return false
            }

            trie = next
        }

        if trie.children[paths[0]] != nil {
            return false
        }

        trie.children[paths[0]] = Trie(value: value, children: [String:Trie]())

        return true
    }

    func get(_ path: String) -> Int {
        var paths = path.components(separatedBy: "/")
        if paths.count <= 1 || paths.first != "" || paths.last! == "" {
            return -1
        }

        paths.removeFirst()

        var trie = self.trie

        while paths.count > 0 {
            let curPath = paths.removeFirst()
            if curPath == "" {
                return -1
            }
            guard let next = trie.children[curPath] else {
                return -1
            }

            trie = next
        }

        return trie.value
    }
}

class Trie {
    var value: Int
    var children: [String:Trie]

    init(value:Int, children:[String:Trie]) {
        self.value = value
        self.children = children
    }
}

/**
 * Your FileSystem object will be instantiated and called as such:
 * let obj = FileSystem()
 * let ret_1: Bool = obj.createPath(path, value)
 * let ret_2: Int = obj.get(path)
 */

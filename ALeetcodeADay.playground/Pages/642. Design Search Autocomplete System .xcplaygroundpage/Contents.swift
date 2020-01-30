//: [Previous](@previous)

import Foundation

/*
 Use Trie to store the sentences. For each char node, we store the sentence that contains this character for quick look up when input character.
 
 */
class Trie {
    var char: String
    
    //Sentence hot degree
    var sentences: [String:Int]
    var children: [String:Trie]
    
    init(char:String, sentences:[String:Int] = [String:Int]() , children:[String:Trie] = [String:Trie]()) {
        self.char = char
        self.sentences = sentences
        self.children = children
    }
    
}

class AutocompleteSystem {
    var head = Trie(char: "*")
    
    //Current node for current input circle
    var curNode = Trie(char: "*")
    
    //Current total inputed character for current input circle
    var curString = [String]()

    init(_ sentences: [String], _ times: [Int]) {
        for i in 0..<sentences.count {
            self.addSentence(sentence: sentences[i], times: times[i])
        }
    }
    
    func addSentence(sentence:String, times:Int) {
        var curNode = self.head
        let chars = sentence.map{String($0)}
        for i in 0..<chars.count {
            let char = chars[i]
            if let child = curNode.children[char] {
                child.sentences[sentence] = child.sentences[sentence, default:0] + times
                curNode = child
            } else {
                let trie = Trie(char: char)
                trie.sentences[sentence] = trie.sentences[sentence, default:0] + times
                curNode.children[char] = trie
                curNode = trie
            }
        }
    }
    
    func input(_ c: Character) -> [String] {
        if curNode.char == "*" {
            curNode = head
        }
        
        let s = String(c)
        if s != "#" {
            self.curString.append(s)

            if let trie = self.curNode.children[s] {
                var sentences = Array(trie.sentences.keys)
                sentences.sort(by:{
                    let fCount = trie.sentences[$0]!
                    let sCount = trie.sentences[$1]!
                    if fCount == sCount {
                        return $0 < $1
                    } else {
                        return fCount > sCount
                    }
                })
                self.curNode = trie
                return sentences.count >= 3 ? Array(sentences[0...2]) : sentences
            } else {
                let trie = Trie(char:s)
                self.curNode.children[s] = trie
                self.curNode = trie
                return [String]()
            }
        } else {
            self.curNode = head
            self.addSentence(sentence: self.curString.joined(), times: 1)
            self.curString = [String]()
            return [String]()
        }
    }
}

/**
 * Your AutocompleteSystem object will be instantiated and called as such:
 * let obj = AutocompleteSystem(sentences, times)
 * let ret_1: [String] = obj.input(c)
 */

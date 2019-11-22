//: [Previous](@previous)

import Foundation

//721. Accounts Merge


func accountsMerge(_ accounts: [[String]]) -> [[String]] {
    guard accounts.count > 0 else {
        return [[String]]()
    }
    
    var emailToName = [String:String]()
    
    let ufs = UnionFind<String>()
    
    for account in accounts {
        let name = account[0]
        
        for i in 1..<account.count {
            emailToName[account[i]] = name
            //Only add new set if the element does not belong to any existing set
            if ufs.findSetByElement(account[i]) == nil {
                ufs.addSetWith(account[i])
            }
            //Join each of email with the first email in the same group
            ufs.union(account[1], secondElement: account[i])
        }
    }
    
    
    var memo = [Int:[String]]()
    
    //Store the emails and associated set index
    for (key, value) in emailToName {
        let name = value
        let index = ufs.findSetByElement(key)!
        if memo[index] == nil {
            memo[index] = [name, key]
        } else {
            memo[index] = memo[index]! + [key]
        }
    }
    
    var result = [[String]]()
    
    for (_ , value) in memo {
        var emails = value
        emails = [emails[0]] + emails[1..<emails.count].sorted()
        
        result.append(emails)
        
    }
    return result
}


class UnionFind<T: Hashable> {
     var index = [T:Int]()
     var parent = [Int]()
     var size = [Int]()
    
    
    public func addSetWith(_ element:T) {
        self.index[element] = self.parent.count
        self.parent.append(parent.count)
        self.size.append(1)
    }
    
    public func findSetByIndex(_ index:Int) -> Int {
        if index != parent[index] {
            parent[index] = self.findSetByIndex(parent[index])
        }
        
        return parent[index]
    }
    
    public func findSetByElement(_ element:T) -> Int? {
        guard let i = self.index[element] else {
            return nil
        }
        
        return self.findSetByIndex(i)
    }
    
    public func union(_ firstElement:T, secondElement:T) {
        if
            let firstSet = self.findSetByElement(firstElement),
            let secondSet = self.findSetByElement(secondElement) {
            if firstSet != secondSet {
                if self.size[firstSet] < self.size[secondSet] {
                    parent[firstSet] = secondSet
                    size[secondSet] += size[firstSet]
                } else {
                    parent[secondSet] = firstSet
                    size[firstSet] += size[secondSet]
                }
            }
        }
    }
}



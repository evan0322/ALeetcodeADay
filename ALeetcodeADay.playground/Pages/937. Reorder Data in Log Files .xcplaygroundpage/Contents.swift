//: [Previous](@previous)

import Foundation

func reorderLogFiles(_ logs: [String]) -> [String] {
    var logs = logs.map{$0.components(separatedBy:" ")}
    // var logs = logs[0] + [Array(logs[1..<logs.count]).joined()]
    
   var letterLog = [[String]]()
    var numLog = [[String]]()
    
    for log in logs {
        if Double(log[1]) != nil {
            numLog.append(log)
        } else {
            letterLog.append(log)
        }
    }
    
    letterLog.sort(by:{
        let s0 = Array($0[1..<$0.count]).joined(separator:" ")
        let s1 = Array($1[1..<$1.count]).joined(separator:" ")
        
        if s0 == s1 {
            return $0[0] < $1[0]
        } else {
            return s0 < s1
        }
    })
    
    return (letterLog + numLog).map{ $0.joined(separator:" ") }
}

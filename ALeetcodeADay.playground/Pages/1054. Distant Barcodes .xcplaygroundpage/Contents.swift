//: [Previous](@previous)

import Foundation

//1054. Distant Barcodes
func rearrangeBarcodes(_ barcodes: [Int]) -> [Int] {
    guard barcodes.count > 0 else {
        return [Int]()
    }
    var result = Array(repeating:0, count:barcodes.count)
    var memo = [Int:Int]()
    
    for code in barcodes {
        memo[code] = memo[code, default:0] + 1
    }
    
    var keys = Array(memo.keys)
    keys.sort(by:{ memo[$0]! < memo[$1]! })
    
    var index = 0
    var num = keys.removeLast()
    var count = memo[num]!
    
    while index < result.count {
        result[index] = num
        count -= 1
        index += 2
        
        if count == 0 && keys.count > 0 {
            num = keys.removeLast()
            count = memo[num]!
        }
        
        if index >= result.count && index%2 == 0 {
            //start to filling odd position (1, 3, 5 .....)
            index = 1
        }
    }
    
    return result
}

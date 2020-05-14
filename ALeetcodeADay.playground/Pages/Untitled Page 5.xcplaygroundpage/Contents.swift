//: [Previous](@previous)

import Foundation

func maximumSwap(_ num: Int) -> Int {
    /*
    9 2 4 8 3 8
    
    9 9 1 8 8
    */
    
   var nums = String(num).map{ Int(String($0))! }

    var bucket = Array(repeating:-1,count:10)
    
    for (i, num) in nums.enumerated() {
        bucket[num] = i
    }
    
    print(bucket)
    
    for (i, num) in nums.enumerated() {
        for j in (num + 1..<10).reversed() {
            if bucket[j] > i {
                nums.swapAt(i, bucket[j])
                return Int(nums.map({String($0)}).joined())!
            }
        }
    }
    
    
    return num
    
  
}

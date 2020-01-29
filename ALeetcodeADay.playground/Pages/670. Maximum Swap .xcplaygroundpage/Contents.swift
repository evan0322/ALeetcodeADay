//: [Previous](@previous)

import Foundation

//Use bucket for finite nums
func maximumSwap(_ num: Int) -> Int {

    var bucket = Array(repeating:-1, count:10)
    
    var nums = String(num).map{Int(String($0))!}
    
    for i in 0..<nums.count {
        bucket[nums[i]] = i
    }
    
    for i in 0..<nums.count {
        for j in (nums[i] + 1..<10).reversed() {
            if bucket[j] > i {
                nums.swapAt(bucket[j], i)
                return Int(nums.map({String($0)}).joined())!
            }
        }
    }
    
    return num
    
}

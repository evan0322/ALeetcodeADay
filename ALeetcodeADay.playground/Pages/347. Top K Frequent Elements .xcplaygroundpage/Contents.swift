//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//347. Top K Frequent Elements

// We first use hash map to record the frequency, then create a bucket with size of nums.count (the max frequncy cannot exceed nums.count). If memo[2] == 8, we put 2 into bucket[8]. Note that different num could have same frequncy, so we need to make bucket a array of array. Then we tranverse the bucket backwards to get the most frequnt num first. Also the result could be larger than k so wo return first k element
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var memo = [Int: Int]()
    
    for num in nums {
        memo[num] = memo[num, default: 0] + 1
    }
    
    var bucket = [[Int]](repeating:[Int](), count:nums.count + 1)
    
    for (key, value) in memo {
        bucket[value] += [key]
    }
    
    var result = [Int]()
    
    for i in (0..<bucket.count).reversed() {
        if bucket[i].count > 0 {
            result += bucket[i]
            if result.count >= k {
                break
            }
        }
    }
    
    return Array(result[0..<k])
}

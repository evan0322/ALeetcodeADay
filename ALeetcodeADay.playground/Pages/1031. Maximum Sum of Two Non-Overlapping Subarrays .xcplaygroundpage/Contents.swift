//: [Previous](@previous)

import Foundation

/*
We can divide the problem into 2 scenarios:
1. L before M
2. M before L
*/
func maxSumTwoNoOverlap(_ A: [Int], _ L: Int, _ M: Int) -> Int {
    guard M + L <= A.count, A.count > 1 else {
        return 0
    }
    
    var sum = A
    
    for i in 1..<sum.count {
        sum[i] += sum[i - 1]
    }
    
    var lMax = sum[L - 1]
    var mMax = sum[M - 1]
    var res = sum[L + M - 1]
            
    // L before M
    // |--L--| x x |-M-| x x
    // once L reaches max, as i keep going, the lmax will not change.
    // Thus we can find the max M while maintaining max L

    for i in L + M..<A.count {
        lMax = max(lMax, sum[i - M] - sum[i - L - M])
        let curSum = lMax + sum[i] - sum[i - M]
        res = max(res, curSum)
    }
    
    // M before L
    // |-L-| x x |--M--| x x
    for i in L + M..<A.count {
        mMax = max(mMax, sum[i - L] - sum[i - M - L])
        let curSum = mMax + sum[i] - sum[i - L]
        res = max(res, curSum)
    }
    
    return res
    
}

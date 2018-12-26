
import Foundation

//311. Sparse Matrix Multiplication
class Solution {
    func multiply(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
        guard A.count > 0 && B.count > 0 else {
            return [[Int]]()
        }
        
        var result = [[Int]](repeating:[Int](repeating:0, count:B[0].count), count:A.count)
        
        func fillResult(i:Int, j:Int) {
            var sum = 0
            var m = 0
            
            for m in 0..<A[i].count {
                sum += A[i][m] * B[m][j]
            }
            
            result[i][j] = sum
        }
        
        for i in 0..<result.count {
            for j in 0..<result[i].count {
                fillResult(i:i, j:j)
            }
        }
        
        return result
    }
}

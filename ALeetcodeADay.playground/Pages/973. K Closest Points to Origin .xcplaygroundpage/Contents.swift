//: [Previous](@previous)

import Foundation

//973. K Closest Points to Origin

func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
     
     var resultIndex = -1
     var points = points
     
    func quickSort(nums: inout [[Int]], low:Int, high:Int) {
        if low < high {
             let index = partition(nums:&nums,low:low,high:high)
             if index == K - 1 {
                 resultIndex = index
                 return
             } else if index < K {
                 quickSort(nums:&nums, low:index + 1, high:high)
             } else {
                 quickSort(nums:&nums, low:low, high:index - 1)
             }
        }
    }
     
     func partition(nums: inout [[Int]], low:Int, high:Int) -> Int {
         let pivot = nums[high]
         var i = low
         for j in i..<high {
             //Note this must be less or equal
             if distance(nums[j]) <= distance(pivot) {
                 nums.swapAt(i, j)
                 i += 1
             }
         }
         
         nums.swapAt(i, high)
         return i
     }
     
     func distance(_ num:[Int]) -> Double {
         guard num.count == 2 else {
             return 0.0
         }
         return (pow(Double(num[0]), 2) + pow(Double(num[1]), 2)).squareRoot()
     }
     
     quickSort(nums: &points, low:0, high:points.count - 1)
     
     //Sometimes the index is not found but the sort is finished. Simply return the first K element
     return resultIndex == -1 ? Array(points[0...K - 1]) : Array(points[0...resultIndex])
 }

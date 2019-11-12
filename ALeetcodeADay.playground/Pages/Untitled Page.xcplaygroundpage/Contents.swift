
import Foundation

// Binary Search
// Return the first element in [low, high) that is larger or equal to value
func binarySearch(array:[Int], value:Int) -> Int{
    var low = 0
    var high = array.count
    
    while low < high {
        let mid = low + (high - low)/2
        if array[mid] < value {
            low = mid + 1
        } else {
            high = mid
        }
    }
    
    return low == array.count ? -1 : low
}


var index = binarySearch(array: [-1, 0, 0, 3, 3, 3, 7, 8, 9], value: 10)

print(index)

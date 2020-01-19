//: [Previous](@previous)

import Foundation

//744. Find Smallest Letter Greater Than Target
func nextGreatestLetter(_ letters: [Character], _ target: Character) -> Character {
    var low = 0
    var high = letters.count
    
    while low < high {
        let mid = low + (high - low)/2
        if letters[mid] <= target {
            low = mid + 1
        } else {
            high = mid
        }
    }
    
    return low == letters.count ? letters.first! : letters[low]
}

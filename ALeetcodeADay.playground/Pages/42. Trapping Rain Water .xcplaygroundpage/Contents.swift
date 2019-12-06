//: [Previous](@previous)

import Foundation

//We need to keep track of a bar's left heigher bar and right heigher bar. Then the water on top of the bar and in between the two bars are (min(height[lLarger],height[rLarger]) - height[cur]) * (rLarger - lLarger - 1). Note we are not calculating the water in height, instead we are calculating the water horizontally

/*
 For bar 5 we are calculating the water that 2 and 6 can hold horizontally which has 5 as base.
 []        []
 [][] x x x[]
 [][][][][][]
 1 2 3 4 5 6
 */
func trap(_ height: [Int]) -> Int {
    guard height.count > 0 else {
        return 0
    }
    
    var stack = [Int]()
    var result = 0
    
    for i in 0..<height.count {
        if stack.count == 0 || height[i] <= height[stack.last!] {
            stack.append(i)
        } else {
            while (stack.count > 0 && height[i] >  height[stack.last!]) {
                let cur = stack.removeLast()
                
                if stack.count > 0 {
                    let lLarger = stack.last!
                    let rLarger = i
                    
                    result += (min(height[lLarger],height[rLarger]) - height[cur]) * (rLarger - lLarger - 1)
                }
            }
            
            stack.append(i)
        }
    }
    return result
}


func solve() {
    print(self.trap([0,1,0,2,1,0,1,3,2,1,2,1]))
    
}

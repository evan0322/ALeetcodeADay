import Foundation


//8.4 Power Set: Write a method to return all subset of a set
func powerSet(set:[Int])->[[Int]] {

    if set.count == 0 {
        return [[Int]]()
    }

    var dp = [[Int]]()
    
    for i in 1..<set.count {
        for dpElement in dp {
            let newCom = dpElement + [set[i]]
            dp.append(newCom)
        }
        dp.append([set[i]])
    }


    return dp
}


//powerSet(set: [1, 3, 9, 10])

//var dp = Array(repeating: [Int](), count: 10 + 1)
//8.13 Stack of boxes
/*
 The idea is the same as LIS. We break the problem into smaller problem: for each box as bottom, what is the max height?
 To do this, we traverse each of the box, and check the max height we had before, If the current box can be part of the previous stack (i.e. sortedBox[i][0] > sortedBox[j][0] && sortedBox[i][2] > sortedBox[j][2] ) then it can be the new bottom of the previous stack. So dp[i] = dp[j] +  sortedBox[i][1]. However, Since we are traversing the previous boxes, we need to keep track of max. So max(currentMax, dp[j] +  sortedBox[i][1]).
 
 Note the difference between this problem and LIS problem. In this problem, the boxes does not have a fixed order, we need the put the box into right order to get the max height. So we have to sort it with one dimention first to ensure we are going towards the right direction.

 */
func maxHeightOfBoxes(boxes:[[Int]]) -> Int {
    if boxes.count == 0 {
        return 0
    }
    
    var sortedBox = boxes
    sortedBox.sort{ $0[1] < $1[1] }
    
    var dp = [Int]()
    for box in sortedBox {
        dp.append(box[1])
    }
    
    for i in 0..<sortedBox.count {
        var currentMax = dp[i]
        for j in 0..<i {
            if sortedBox[i][0] > sortedBox[j][0] && sortedBox[i][2] > sortedBox[j][2] {
                currentMax = max(currentMax, dp[j] +  sortedBox[i][1])
            }
        }
        
        dp[i] = currentMax
    }
    
    var maxHeight = 0
    for element in dp {
        maxHeight = max(maxHeight, element)
    }
    
    return maxHeight
    
}

//maxHeightOfBoxes(boxes: [[6,9,10], [8,10, 12], [1, 13, 9], [4,2,4], [2, 14,11]])


//8.11 coins
func coins(n: Int) -> Int {
    var memo = Array(repeating: Array(repeating: 0, count: 5), count: n + 1)
    
    func make(cents:Int, coins:[Int], index: Int) -> Int {
        if index == coins.count - 1 {
             // When the index reaches the last coin option(e.g. coint with 1 cent) We always have 1 way to present the cents (i.e. all 1 cents)
            return 1
        } else if memo[cents][index] > 0{
            return memo[cents][index]
        } else {
            var ways = 0
            var i = 0
            while i*coins[index] <= cents {
                ways += make(cents: cents - i*coins[index], coins: coins, index: index + 1)
                i += 1
            }
            memo[cents][index] = ways
            return ways
        }
    }
    
    
    return make(cents: n, coins: [25, 10, 5, 1], index: 0)
}

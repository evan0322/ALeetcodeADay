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


powerSet(set: [1, 3, 9, 10])

//var dp = Array(repeating: [Int](), count: 10 + 1)

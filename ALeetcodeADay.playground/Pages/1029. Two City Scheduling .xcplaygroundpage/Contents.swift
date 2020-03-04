import Foundation

var str = "Hello, playground"

//Find out how much money we can save by flying to A instead of flying to B?
func twoCitySchedCost(_ costs: [[Int]]) -> Int {
    var costs = costs
    costs.sort(by:{ $0[0] - $0[1] <  $1[0] - $1[1]})
    
    var total = 0
    
    for i in 0..<costs.count {
        if i < costs.count/2 {
            total += costs[i][0]
        } else {
            total += costs[i][1]
        }
    }
    
    return total
}

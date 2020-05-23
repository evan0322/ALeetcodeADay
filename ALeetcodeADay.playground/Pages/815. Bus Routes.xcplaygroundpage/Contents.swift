//: [Previous](@previous)

import Foundation

func numBusesToDestination(_ routes: [[Int]], _ S: Int, _ T: Int) -> Int {
    guard S != T else {
        return 0
    }
    //[station: [routeIndex]]
    var toRoute = [Int:Set<Int>]()
    
    for i in 0..<routes.count {
        for station in routes[i] {
            if var routeSet = toRoute[station] {
                routeSet.insert(i)
                toRoute[station] = routeSet
            } else {
                var routeSet = Set<Int>()
                routeSet.insert(i)
                toRoute[station] =  routeSet
            }
        }
    }
    
    
    //BFS
    var bfs = Set<Int>()
    bfs.insert(S)
    
    var count = 1
    var visitedRoute = Set<Int>()
    while bfs.count != 0 {
        var newBfs = Set<Int>()
        for station in bfs {
            guard let routeIndexes = toRoute[station] else {
                continue
            }
            for routeIndex in routeIndexes {
                if visitedRoute.contains(routeIndex) {
                    continue
                }
                visitedRoute.insert(routeIndex)
                let stations = routes[routeIndex]
                newBfs = newBfs.union(Set(stations))
            }
        }
        if newBfs.contains(T) {
            return count
        }
                    
        bfs = newBfs
        count += 1
    }
    
    return -1
}

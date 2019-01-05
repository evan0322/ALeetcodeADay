import Foundation

// 210. Course Schedule II
/*
 The difference between 210. Course Schedule II and 207. Course Schedule is that we need to print out the result not only detect if loop exists. In this case we need to do the same thing as Course Schedule I. However, we need to dps with post order, meaning that we need to visit all the prerequisites of the node (e.g. all node connected to current node) then visit node itself when the prerequisite is finished.
 Samilarly, we keep track of current visited node and the node visited in current dfs. If a visited node appears then a loop if detected.
 Note tha we always ask the dfs function to return false if a loop is detected and true if the taverse is compeleted successfully.
 Time: O(n) since we only visit each node once
 Space: O(n) graph
 */
func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
    guard numCourses > 0 else {
        return [Int]()
    }
    
    var result = [Int]()
    var graph = [Int: [Int]]()
    
    for p in prerequisites {
        graph[p[0]] = graph[p[0], default:[Int]()] + [p[1]]
    }
    
    var memo = [Int: Bool]()
    
    func dfs(index:Int, path:[Int:Bool]) -> Bool {
        if path[index] == true {
            return false
        }
        
        if memo[index] == true {
            return true
        }
        var path = path
        //We need to set the path to true whenever we go through a node.
        // If we do it after dfs takes action then it is too late as loop is already created
        path[index] = true
        
        if let neighb = graph[index] {
            for ne in neighb {
                if !dfs(index:ne, path: path) {
                    return false
                }
            }
        }
        
        result.append(index)
        memo[index] = true
        return true
    }
    
    for i in 0..<numCourses {
        if !dfs(index:i, path:[Int:Bool]()) {
            return [Int]()
        }
    }
    
    return result
    
}

// 210. Course Schedule II
/*
 Use topology to solve the dependency issue. If a course is depending on another node, we increase the degree count for that node by 1.
 Then we traverse the possible courses. Put all the node that degree equals to 0 to the queue. do a BFS. for each of the node that depends on current node, we decresse the degree. if the degree becomes 0, we also put that in the queue.
 
 Finally we check if the course we take matches the total num of courses
 */
func findOrderV2(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
    guard numCourses > 0 else {
        return [Int]()
    }
    
    var memo = [Int:[Int]]()
    var degree = [Int: Int]()
    
    for p in prerequisites {
        memo[p[1]] = memo[p[1], default:[Int]()] + [p[0]]
        degree[p[0]] = degree[p[0], default:0] + 1
    }
    
    var result = [Int]()
    var queue = [Int]()
    
    for i in 0..<numCourses {
        if let d = degree[i] {
            if d == 0 {
                queue.append(i)
            }
        } else {
            queue.append(i)
        }
    }
    
    while queue.count > 0 {
        let cur = queue.removeFirst()
        result.append(cur)
        if let courses = memo[cur] {
            for course in courses {
                if let d = degree[course] {
                    degree[course] = d - 1
                    if d - 1 == 0 {
                        queue.append(course)
                    }
                }
            }
        }
    }
    
    return result.count == numCourses ? result : [Int]()
}

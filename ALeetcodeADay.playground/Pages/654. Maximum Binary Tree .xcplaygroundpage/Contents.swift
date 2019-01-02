import Foundation


//Use decreasing monotonic stack
//654. Maximum Binary Tree
func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
    guard nums.count > 0 else {
        return nil
    }
    
    var stack = [TreeNode]()
    var head = TreeNode(0)
    
    for i in 0..<nums.count {
        head = TreeNode(nums[i])
        while stack.count > 0 && stack.last!.val < head.val {
            head.left = stack.removeLast()
        }
        
        if stack.count != 0 {
            stack.last!.right = head
        }
        
        stack.append(head)
    }
    
    return stack.first!
    
}

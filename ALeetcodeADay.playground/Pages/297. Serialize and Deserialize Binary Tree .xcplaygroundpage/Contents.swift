//: [Previous](@previous)

import Foundation


/*
1. Nested function
2. Be careful about negative value. Must have separator in encoded string
 */

/*
 
 class Codec:

 def serialize(self, root):
     """Encodes a tree to a single string.

     :type root: TreeNode
     :rtype: str
     """
     data = ''

     def encode(node):
         nonlocal  data
         if node is None:
             data += '# '
         else:
             data += f'{node.val} '
             encode(node.left)
             encode(node.right)

     encode(root)
     return  data




 def deserialize(self, data):
     """Decodes your encoded data to tree.

     :type data: str
     :rtype: TreeNode
     """

     data = data.split()
     i = -1
     def decode():
         nonlocal i
         i += 1
         if i >= len(data) or data[i] is '#':
             return None
         else:
             node = TreeNode(data[i])
             node.left = decode()
             node.right = decode()
             return node

     n = decode()
     return n
 */


func serialize(_ root: TreeNode?) -> String {
    var string = [String]()
    
    func traverse(_ node:TreeNode?) {
        guard let node = node else {
            string.append("*")
            return
        }
        
        string.append(String(node.val))
        traverse(node.left)
        traverse(node.right)
    }
    
    traverse(root)
    return string.joined(separator:" ")
}

func deserialize(_ data: String) -> TreeNode? {
    var string = data.components(separatedBy:" ")
    var index = 0
    
    func buildTree() -> TreeNode? {
        if index >= string.count || string[index] == "*" {
            //Important
            index += 1
            return nil
        }
        
        var node = TreeNode(Int(string[index])!)
        index += 1
        node.left = buildTree()
        node.right = buildTree()
        return node
    }
    
    let root = buildTree()
    return root
}

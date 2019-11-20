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

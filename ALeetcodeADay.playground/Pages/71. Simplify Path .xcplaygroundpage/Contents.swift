//: [Previous](@previous)

import Foundation

func simplifyPath(_ path: String) -> String {
     let elements = path.split(separator:"/")
     
     var stack = [String]()
     
     for element in elements {
         if element == "." || element == "" {
             continue
         } else if element == ".." {
             if !stack.isEmpty {
                 stack.removeLast()
             }
         } else {
             stack.append(String(element))
         }
     }
     
     return "/" + stack.joined(separator:"/")
 }

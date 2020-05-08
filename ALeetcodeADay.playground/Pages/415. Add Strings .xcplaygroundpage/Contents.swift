//: [Previous](@previous)

import Foundation

func addStrings(_ num1: String, _ num2: String) -> String {
     /*
     1239
      234
     
     9 3 2 1
     4 3 2
     
     3 7 4 1
     
     1473
     */
     var num1 = Array(num1.map({String($0)}).reversed())
     var num2 = Array(num2.map({String($0)}).reversed())
     
     var addition = 0
     var newString = [String]()
     
     var maxIndex = max(num1.count, num2.count)
     
     for i in 0..<maxIndex {
         var newInt = 0
         if i < num1.count {
             newInt += Int(num1[i])!
         }
         
         if i < num2.count {
             newInt += Int(num2[i])!
         }
         
         newInt += addition
         
         addition = newInt/10
         newInt = newInt%10
         
         newString.append(String(newInt))
     }
     
     if addition == 1 {
         newString.append("1")
     }
     
     return newString.reversed().joined()  
 }

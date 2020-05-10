//: [Previous](@previous)

import Foundation

//273. Integer to English Words

func numberToWords(_ num: Int) -> String {
     let lessThan20 = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"]
     let tens = ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]
     let thousands = ["", "Thousand", "Million", "Billion"]
     
     guard num > 0 else {
         return "Zero"
     }
     
     func getWord(num: Int) -> String {
         if num == 0 {
             return ""
         } else if num < 20 {
             return lessThan20[num] + " "
         } else if num < 100 {
             return tens[num/10] + " " + getWord(num: num%10)
         } else {
             return lessThan20[num/100] + " Hundred " + getWord(num:num%100)
         }
     }
     
     var i = 0
     var num = num
     var word = ""
     
     while num != 0 {
         if num % 1000 != 0 {
             let string = getWord(num:num%1000)
             word = string + thousands[i] + " " + word
         }

         i += 1
         num /= 1000
     }
     
     return word.trimmingCharacters(in:.whitespacesAndNewlines)
 }

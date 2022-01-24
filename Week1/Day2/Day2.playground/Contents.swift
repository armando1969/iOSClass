import Foundation
import Darwin

// Control Flow

var scores: [Float] =  [0.6, 0.4, 0.9, 0.9, 0.3]
var highest = [Float]()
var average: Float = 0.0

// For loop

for score in scores {
    if score >= 0.8999 {
        highest.append(score)
    }
    average += score
    
}
average = average/Float(scores.count)

print(average)
print(highest)

average = 0.0
highest = []

let range = 10...20
print(range.contains(20))

for i in 0..<scores.count {
    let score = scores[i]
    if score >= 0.8999 {
        highest.append(score)
    }
    average += score
}
average = average/Float(scores.count)

print(average)
print(highest)

for (index, value) in scores.enumerated() {
    print(index)
    print(value)
}

for score in scores where score > 0.8999 {
    print(score)
}

let string = "hello world"                                                          //string
for char in string {
    print(char)
}

let interNum = ["prime": [2, 3, 5, 7, 11, 13], "fibonacci": [ 1, 1, 2, 3, 5, 8]]       //Dictionary
for (_, value) in interNum {
   // print(key)
    print(value)
}

// switch

let veg = "red pepper"

switch veg {
case "Celery":
    print("Celery")
case let x where x.hasSuffix("pepper"):
    print("it is a spicy \(x)?")
    
default:
    print("default Case")
}

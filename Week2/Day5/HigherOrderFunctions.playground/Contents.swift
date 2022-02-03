import UIKit
import Foundation

let StringArrayE = ["1", "2", "3", "A", "B", "5"]
let arrayOfArray = [[1, 2, 3], [2, 4], [5]]
let IntArray2 = [1, 2, 3, 4, 5, 6, 4, 11]
let IntArray = StringArrayE.map ({ element in return Int(element)})
print(IntArray)

//alternate version
let intArray = StringArrayE.map({ element -> Int? in
    let intValue = Int(element)
    return intValue
    
})
var arrayOfSorted = arrayOfArray.sorted(by: { array1, array2 in
    let total1 = array1.count
    let total2 = array2.count
    return total1 < total2
})
print(arrayOfSorted)

arrayOfSorted = arrayOfArray.sorted(by: { $0.count < $1.count })
print(arrayOfSorted)

var filteredArray = arrayOfArray.filter({ $0.contains(4)})
print(filteredArray)

var reducedValue = arrayOfArray.reduce(0, { intialValue, nextValue -> Int in
    var initial = intialValue
    initial += nextValue.count
    return initial
})

reducedValue = IntArray2.reduce(0, { initialValue, nextValue -> Int in
    var initial = initialValue
    initial += nextValue
    return initial
})

print(reducedValue)

var reducedValue3 = arrayOfArray.reduce([Int](), { initialValue, nextValue -> [Int] in
    var initial = initialValue
    initial += nextValue
    return initial
})
/*
var reducedValue2 = arrayOfArray.reduce([Int](), { initialValue, nextValue -> [Int] in
     var initialValue = initialValue
     initialValue += nextValue
     return initialValue
 })
*/
print(reducedValue3)

print(IntArray.count)

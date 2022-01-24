import UIKit

func sockPairs(n: Int, ar: [Int]) -> Int {
    var pairs: Int = 0
    var temp: Int = 0
    var second: Int = 0
    var array = ar
    
    for i in 0..<array.count {
        temp = array[i]
        second = second + 1
    
        for j in second..<array.count {
            if temp == array[j] && array[j] != 0{
                pairs = pairs + 1
                array[j] = 0
                temp = -1
            }
        }
    }
    
    return pairs
}

let numberOfSocks = sockPairs(n: 9, ar: [10, 20, 20, 10, 10, 30, 50, 10, 20])

print(numberOfSocks)

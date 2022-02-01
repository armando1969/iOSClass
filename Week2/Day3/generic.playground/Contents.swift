import UIKit
import Security
import Foundation

let aryInt = Array<Int>()
let aryString = Array<String>()

//Stack a LIFO collection type

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    func printInConsole() {
        for element in items {
            print(element)
        }
    }
}

struct StrStack {
    var items = [String]()
    mutating func push(_ item: String) {
        items.append(item)
    }
    mutating func pop() -> String {
        return items.removeLast()
    }
    func printInConsole() {
        for element in items {
            print(element)
        }
    }
}
/*
var intStack = IntStack()
intStack.push(2)
intStack.push(4)
intStack.push(5)
intStack.printInConsole()
print(intStack.pop())

var StringStack = StrStack()
StringStack.push("Armando")
StringStack.push("Florencio")
StringStack.push("Sergio")
StringStack.printInConsole()
print(StringStack.pop())
 

struct Stack<Element> {
    private var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    func printInConsole() {
        for element in items {
            print(element)
        }
    }
} */
protocol Stack {
    associatedtype Element
    var items: [Element] { get set }
    mutating func push(_ item: Element)
    mutating func pop() -> Element
    
}

extension Stack {
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

enum CustomError: Error {
    case badURL
    case badParData
}

let result = Result<[String], CustomError>.success([""])
switch result {
case .success(let success):
    print(success)
case .failure(let failure):
    print(failure.localizedDescription)
}
// POP protocol oriented programing we have to think in relation of protocol when we program

struct CustomStruct<Element>: Stack {
    var items: [Element] = []
    
}

var GenStack = CustomStruct<String>()
GenStack.push("Armando")
GenStack.push("1")
GenStack.push("Sergio")
GenStack.push("5")
print(GenStack.pop())
print(GenStack.pop())

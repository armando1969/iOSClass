import UIKit
import Foundation

let name: String = "Armando"

/*func MyFunc() -> Void {
    
} */

// Closure

var closure: () -> Void = {
    print("My Closure")
}

closure()

closure = {
    print("another message")
}
typealias Closure = (Int) -> Void

func fetchFromApi(from url: String, completion: Closure) {
    let numFromAPI = 200
    completion(numFromAPI)
}

fetchFromApi(from: "https://api.themoviedb.org", completion: { codeAny in  print(codeAny)})

fetchFromApi(from: "https://apiu.themoviedb.org") { codeAny in
    print(codeAny)
}

//Higher Order Functions

let names = ["Armando", "Sergio", "Ramon", "Mary Ann"]

let sortedNames = names.sorted(by: { name1, name2 in return name1 < name2})

print(sortedNames)

let sortedNames2 = names.sorted(by: { name1, name2 in name1 < name2})

print(sortedNames2)

let sortedNames3 = names.sorted(by: { $0 < $1})

print(sortedNames3)

let sortedNames1 = names.sorted()
print(sortedNames1)

// Enumerations

enum compassPoints: Int, CaseIterable{
    case north
    case south
    case east
    case west
}

print(compassPoints.east.rawValue)

for compassCase in compassPoints.allCases {
    print(compassCase)
    print(compassCase.rawValue)
}

enum Activity {
    case bored
    case running(destination : String)
    case talking(topic: String)
    case singing(volume: Int)
    
    var property: String {                          //no stored properties only computed properties
        return "this is my property"
    }
}

let talking = Activity.talking(topic: "politics")

print(talking)
print(talking.property)


switch talking {
    case .bored:
        print("I am bored")
    case .running:
        print("I am running")
    case .talking(topic: let topic):
        print("talking about \(topic)")
    case .singing:
        print("I am Singing")
}


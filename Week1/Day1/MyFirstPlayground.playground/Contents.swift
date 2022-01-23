import Foundation

let num: Int = 12 //inmutable

var Banana: String = "a fruit" //mutable
let array = Banana.components(separatedBy: " ")
print(array)
print(num)
print (Banana)


var optional: String?           //optional declaration

print(optional)
optional = "A VALUE"

print(optional)
print(optional!)            //forced unbinding

let sentance: String = "I have \(num) Bananas which is \(Banana).  \nanother line"   //string concatination

print(sentance)

let year = "2022"
if let currentYear = Int(year) {                    //optional binding

print(currentYear)
}
else {
    print("this is a nil")                      //exception handling
}

//Functions

func func1 () -> Void {
    print("Florencio Armandop Gallegos Gutierrez")
}

func1()

func greeting(whatEver name: String = "default Name", age: Int = 1) -> String {                                     //A function structure
    return "Hello myn nane is \(name) and I am \(age) years old"
}
let greet = greeting(whatEver: "Armando", age: 50)
    print(greeting(whatEver: "Florencion Gallegos", age: 50))
print(greeting())

print(greet)

var age2: String? //= "50"

func chaining(age: String?) -> String? {                                                                            //Chain unbinding
    var age = age
    age?.append(" is my age")
    return age
}
                                                                                                                    //optional binding again
if let chain = chaining(age: age2) {
    print(chaining(age: age2)!)
}
else {
    print("it is a nil")
}

/*
 Collection types  --  a type that can collect different types
-Array
 -Dictionary
 -Set
 */

//Array

var ages: [Int] = [15,22,13]
var ages2 = [Int]()
var ages3: [Int] = []
var age4: Array<Int> = []

ages.append(50)
ages.append(13)
ages.append(22)
print(ages.sorted())

//Dictionary  - a collection of values accessed by a unique key


var dictionary = ["firstName": "Armando", "lastName": "Gallegos"]
var dictionary2: [Int : String] = [:]
var dictionary3 = Dictionary<Int, String>()
var dictonary4 = [Int:String]()

dictionary2[100] = "File Not Found"
dictionary2[200] = "empty file"

print(dictionary2[200])
print(dictionary["firstName"])


//Set  - an ordered collection of unique values
let setOfAges = Set(ages)
print((setOfAges))

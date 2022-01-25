import Foundation

//classes are reference types
//structs are value types

//int float, double string, () -> void {} are types
//classes and structs are custom types

struct resolution {
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {                     //this is optional, compiler will create otherwise
        self.width = width
        self.height = height
    }
    static let storedProperty = "Some Value"            //example of a singleton
    static var computedProperty: Int {
        1
    }
}

let someResolution = resolution(width: 0, height: 0 )

print(resolution.storedProperty)
print(resolution.computedProperty)

class videoMode {
    let name: String
    let frameRate: Double
    static let storedProperty = "Store Property"          //the same as with structs a singleton
    class var computedProperty: Int {
        1
    }
    
    init(name: String, frameRate: Double) {               //This is mandatory, will generate an error otherwise
        self.name = name
        self.frameRate = frameRate
    }
    func someFunc() {
        print("parent")
    }
}

let someVideoMode = videoMode(name: "", frameRate: 0.0)

print(someResolution.height)
print(someVideoMode.frameRate)

class videoModeChild: videoMode {
    
    func Init() {
        
    }
    override func someFunc() {
        print("child")
    }
}

let video = videoMode(name: "", frameRate: 2.0)
let video1 = videoModeChild(name: "", frameRate: 1.0)
print(video.someFunc())
print(video1.someFunc())
// access control

//Internal - it can be used used inside the current project classes and structs are internal by default
//private - can only be used inside the calling struct or class
//public - is available for use by any project
//open - only for classes and it can be overiden in the calling project

//retain cycle in classes

class Apartment {
    var apptNum: Int
    weak var aptTenant: tenant?
    
    init(apptNum: Int) {
        self.apptNum = apptNum
       // self.aptTenant = aptTenant
    }
}

class tenant {
    let tenantName: String
    
    init(tenantName: String) {
        self.tenantName = tenantName
    }
    
    deinit {
        print("tenant \(tenantName) has been removed")
    }
}

var apt: Apartment = Apartment(apptNum: 10)

var someTenant: tenant? = tenant(tenantName: "armando")         //ARC for tenant gors to 1

apt.aptTenant = someTenant                                      //ARC foer tenant goes to 2

someTenant = nil                                                //ARC for tenant goes to 0
print("here")
apt.aptTenant = nil                                             //ARC for tenant is still 0

//Protocol - is a blue print of methods, properties, and other requirements that suit a particular task or piece of functionality.
//protocols can be inherited by a class, struct or enum
//you can extend a protocol to implement some of these requirements or to implement additional functionality that the callint type can take advantage of

//POP protocol oriented programing
// we start designing the system by designing the protocols first

protocol Binary {
    mutating func update(data: Data)
    var tag: String { get set}
    var data: Data {get}
    
}

protocol NewProtocol: Binary {
    func upDate()
}

//Extension a decorator of an excisting class, struct or protocol

extension String {
    func convertToInt() -> Int? {
        return Int(self)
    }
}

extension NewProtocol{
    func upDate() {
        print("print something")
    }
}

let prot: NewProtocol

let string = "2"

struct customStruct: Binary {
    
    var tag: String
    var data: Data
    
    mutating func update(data: Data) {
        self.data = data
        
    }
}

class customClass:Binary {
    
    var tag: String
    var data: Data
    
    init(tag: String, data: Data) {
        self.tag = tag
        self.data = data
    }
    func update(data: Data) {
        
    }
}

let array = [Binary]()
let b1 = customClass(tag: "", data: Data())
let b2 = customStruct(tag: "", data: Data())

//array.append(b1)
//array.append(b2)

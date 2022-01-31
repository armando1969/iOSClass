import UIKit
import Foundation

//this is the delegation pattern
//one to one communication

protocol myProtocol: AnyObject          {       //a blue print of properties, and functionalities.  a                                               behavior of a class or struct
func printConsole(_ message: String)
    
}

class firstClass {
    var delegate: myProtocol?
    
    func delegateFunc(_ message: String) {
        delegate?.printConsole(message)
    }
}

class secondClass {
    
    weak var firstClass: firstClass?

    
  //  func setFirstClass(_ firstClass: firstClass) {
    init (firstClass: firstClass) {
        self.firstClass = firstClass            //dependency injection
        self.firstClass?.delegate = self
    }
    
    func printName() {
        firstClass?.delegateFunc("Florencio Gallegos")
    }
}

extension secondClass: myProtocol {
    
    func printConsole(_ message: String) {
        let customMessage = "from the second class: \(message)"
        print(customMessage)
    }
}

let Class1 = firstClass()
let Class2 = secondClass(firstClass: Class1)

Class1.delegateFunc("hi Back")
Class2.printName()



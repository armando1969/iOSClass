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

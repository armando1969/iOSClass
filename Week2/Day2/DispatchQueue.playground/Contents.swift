import UIKit

let range = 0..<100


DispatchQueue.global(qos: .background).async {
    for i in range {
        print("new threat: \(i)")
    }
}

for i in range {
    print("main threat: \(i)")
}

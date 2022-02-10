import UIKit
import Combine


var array = (1...100)

let publisherInts = array.publisher

publisherInts
    .dropFirst(50)
    .prefix(20)
    .filter {  $0 % 2 == 0}
    .sink { print($0) }
//let cancellable = publisherInts
//    .dropFirst
//    .map { "\($0)" }
//    .removeDuplicates()
//    .filter( { output in
//        return output < "7"
//    })
//    .sink { value in
//    print(value)
//}


//Networking
let url = "https://jsonplaceholder.typicode.com/posts"

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

func getPosts() -> AnyPublisher<[Post], Error> {
    
    guard let url = URL(string: url) else {
        fatalError()
    }
    
    return URLSession
        .shared
        .dataTaskPublisher(for: url)
        .map( { data, response in
            return data
        })
        .decode(type: [Post].self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

let publisher = getPosts()

var subscribers = Set<AnyCancellable>()

publisher.sink { _ in } receiveValue: { response in
    print("subscriber")
    print(response.count)
}
    .store(in: &subscribers)

let subscriber = getPosts()
    .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("downloaded the image")
        case .failure(let error):
            print(error.localizedDescription)
        }
    },
        receiveValue: { response in
        print(response.count)
    })
//print(subscriber)

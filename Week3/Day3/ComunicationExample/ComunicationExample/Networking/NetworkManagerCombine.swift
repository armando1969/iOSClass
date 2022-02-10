//
//  NetworkManagerCombine.swift
//  ComunicationExample
//
//  Created by Consultant on 2/8/22.
//

import Foundation
import Combine

class NetworkManagerCombine {
    
    func getPosts(from url: String) -> AnyPublisher<[Post], Error> {
        
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
    
}

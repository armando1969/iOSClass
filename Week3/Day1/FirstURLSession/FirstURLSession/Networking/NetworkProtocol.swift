//
//  NetworkProtocol.swift
//  FirstURLSession
//
//  Created by Consultant on 2/3/22.
//

import Foundation

protocol NetworkProtocol {
    associatedtype Model: Codable
    func get(from url: String, completion :@escaping(Result<Model, NetworkError>) -> Void)
}

extension NetworkProtocol {
    
    func get(from url: String, completion :@escaping(Result<Model, NetworkError>) -> Void) {
    guard let url = URL(string: url) else {
        completion(.failure(.badURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(.other(error)))
            return
        }
        
        if let data = data {
            do {
                let response = try JSONDecoder().decode(Model.self, from: data)
                completion(.success(response))
               // print(data)
                } catch let error {
                completion(.failure(.other(error)))
            }
        }
    }
    .resume()
    }
}

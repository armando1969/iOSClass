//
//  NetworkManager.swift
//  ComunicationExample
//
//  Created by Consultant on 2/8/22.
//

import Foundation
    
    class NetworkManagerClosure {

        
        func getModel<T: Decodable>(_ model: T.Type, from url: String, completion :@escaping(Result<T, NetworkError>) -> Void) {
            
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
                        let response = try JSONDecoder().decode(model, from: data)
                        completion(.success(response))
                        print(data)
                        } catch let error {
                        completion(.failure(.other(error)))
                    }
                }
            }
            .resume()
            
        }
        
    }

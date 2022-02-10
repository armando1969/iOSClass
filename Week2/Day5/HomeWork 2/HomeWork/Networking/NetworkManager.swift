//
//  NetworkManager.swift
//  HomeWork
//
//  Created by Consultant on 1/31/22.
//

import Foundation
import CoreText

class NetworkManager {
    
    
    func getPhotos(from url: String, complition: @escaping (Result<Nasa, NetworkError>) -> Void) {
        guard let url = URL(string: url) else
        {
            complition(Result.failure(NetworkError.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, Response, error in
            if let error = error {
                complition(.failure(.other(error)))
                return
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Nasa.self, from: data)
                    complition(.success(response))
                } catch let error {
                        complition(.failure(.other(error)))
                }
            }
        }
        .resume()
            
        }
}
                

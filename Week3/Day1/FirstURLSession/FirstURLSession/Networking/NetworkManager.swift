//
//  NetworkManager.swift
//  FirstURLSession
//
//  Created by Consultant on 1/31/22.
//

import Foundation
import CoreText

class NetworkManager {

    
    func PostPhotos(_ story: Story, to url: String) {
        guard let url = URL(string: url) else {
            return
        }
        if let data = try? JSONEncoder().encode(story) {
            var UrlRequest = URLRequest(url:  url)
            UrlRequest.httpMethod = "POST"
            UrlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            UrlRequest.httpBody = data
            
            URLSession.shared.dataTask(with: UrlRequest) { data, response, error in
           }
            .resume()
        }
    
    func getModel<T: Codable>(_ model: T.Type, from url: String, completion :@escaping(Result<T, NetworkError>) -> Void) {
        
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
        
    
   
}

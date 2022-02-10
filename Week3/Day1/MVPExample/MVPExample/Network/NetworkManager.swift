//
//  NetworkManager.swift
//  MVPExample
//
//  Created by Consultant on 2/4/22.
//

import Foundation


let trickNamePublisher = NotificationCenter.default.publisher(for: .newTrickDownloader)
//let trickNamePublisher = NotificationCenter.default.publisher(for: .newTrickDownloaded) .map { notification in
//    return notification.userInfo?["data"] as! Data
//}
//
//    .flatMap { data in
//        return Just(data)
//            .decode(MagicTrick.Self, JSONDecoder())
//            .catch {
//    }


class NetworkManager {
    
    func get(from url: String, completion: @escaping (Result<MovieResponse,NetworkError>) -> Void) {
        
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
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(response))
            } catch let error  {
                completion(.failure(.other(error)))
            }
        }
        }
        .resume()
    }
    func getImageData(from url: String, completion: @escaping(Data?) -> Void ) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
    }
        URLSession.shared.dataTask(with: url) { data, response , error in
            completion(data)
        }
        .resume()
    }
}

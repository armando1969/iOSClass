//
//  NetworkManager.swift
//  FirstURLSession
//
//  Created by Consultant on 1/31/22.
//

import Foundation
import CoreText

//enum URLStatus: Int {
//    case unauthorized
//}

// encapsulate all of the functionality of networking

class NetworkManager {
    
    func getPosts(from url: String, complition: @escaping (Result<[Post], NetworkError>) -> ()) {
        
    //    let badCase = NetworkError.badURL
        
        guard let url = URL(string: url) else
        {
            complition(Result.failure(NetworkError.badURL))
            return
        
        }

        let session = URLSession.shared
        session.dataTask(with: url) { data, Response, error in
/*
            if let Response = Response as? HTTPURLResponse {
                if let statusCase = URLStatus(rawValue: Response.statusCode) {
                    if statusCase == .unauthorized {
                        if let data = data {
    
                    }
                }
            }
     */
        if let data = data {
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                complition(.success(posts))
                print(posts.first?.title)
                //old parsing method
      /*              if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    {
                       var posts = [Post]()
                        for item in response {
                            let post = Post.parse(from: item)
                            posts.append(post)
                        }
                        complition(Result.success(posts))
                        print(response)
                    }
                */
                    print(data)
                    } catch let error
                    {
                        complition(.failure(.other(error)))
                    }
                }
            if let error = error {
                complition(Result.failure(NetworkError.other(error)))
            }
        }
        .resume()
    }

}

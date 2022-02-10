//
//  ViewModel.swift
//  pucsumApp
//
//  Created by Consultant on 2/7/22.
//

import Foundation
import Combine

class ViewModel {
    
    @Published var data = Data()
    
    func download(width: Int, height: Int) {
        let url = "https://picsum.photos/\(width)/\(height)"
        
        guard let urlRequest = URL(string: url) else {
            return
        }
                
                URLSession
                    .shared
                    .dataTask(with: urlRequest)
                    //.map (
                    { [weak self] data, response, error in
                    if let data = data {
                        self?.data = data
                    }
                    //    )
                    //        .decode(type: [image].self, decoder: JSONDecoder())
                    //        .eraseToAnyPublisher()
                }
                .resume()
    }
}

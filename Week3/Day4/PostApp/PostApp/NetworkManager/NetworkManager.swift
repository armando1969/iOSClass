//
//  NMetworkManager.swift
//  PostApp
//
//  Created by Consultant on 2/9/22.
//

import Foundation


class NetworkManager {
    
    func getData(completion: @escaping ([Post]) -> Void ) {
        
        guard let url = URL(string: networkURL.url) else {
            print("there was a prioblem with the URL")
            return
        }
     
        URLSession.shared.dataTask(with: url) { data, response , Error in

            if let data = data {
                
                do {
                    let result = try JSONDecoder().decode([Post].self, from: data)
                    completion(result)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        .resume()
}

}

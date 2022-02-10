//
//  ViewModelCombine.swift
//  ComunicationExample
//
//  Created by Consultant on 2/8/22.
//

import Foundation
import Combine

class ViewModelCombine {
    
    private let networkManager = NetworkManagerCombine()
    private var cancellers = Set<AnyCancellable>()
    
    @Published var posts = [Post]()
    
    func getPosts() {
        
        networkManager
            .getPosts(from: NetworkUrl.postUrl)
            .sink(receiveCompletion: { _ in },
                  receiveValue:  { [weak self] response in
                self?.posts = response
            })
            .store(in: &cancellers)
    }
}
        
//        networkManager.getModel([Post].self, from: NetworkUrl.postUrl) { [weak self] result in
//            switch result {
//            case .success(let response):
//                print("downloaded Model")
//                self?.posts = response
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }


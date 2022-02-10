//
//  ViewModelClosure.swift
//  ComunicationExample
//
//  Created by Consultant on 2/8/22.
//

import Foundation

class ViewModelClosure {
    
    private let networkManager = NetworkManagerClosure()
    
    var displayPosts: (([Post]) -> Void)?
    
    func getPost() {
        networkManager.getModel([Post].self, from: NetworkUrl.postUrl) { [weak self] result  in
        switch result {
        case .success(let response):
            print("downloaded Model")
            self?.displayPosts?(response)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    }
    
    func anotherFunc() {
        displayPosts?([])
    }
}

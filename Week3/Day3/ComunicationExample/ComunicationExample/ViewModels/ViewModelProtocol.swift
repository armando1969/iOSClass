//
//  ViewModelProtocol.swift
//  ComunicationExample
//
//  Created by Consultant on 2/8/22.
//

import Foundation

protocol ViewModelProtocolDelegate: AnyObject {
    
    func displayPosts(_ posts: [Post]) 
}

class ViewModelProtocol {
    
    private let networManager = NetworkManagerClosure()
    weak var delegate: ViewModelProtocolDelegate?
    
    func getPost() {
        networManager.getModel([Post].self, from: NetworkUrl.postUrl) { result in
            switch result {
            case .success(let response):
                print("downloaded Model")
                self.delegate?.displayPosts(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func anotherFunc() {
        delegate?.displayPosts([])
    }
    
    func getPostsaWithoutThread() -> Int {
        let url = URL(string: NetworkUrl.postUrl)!
        let data = try! Data(contentsOf: url)
        let response = try! JSONDecoder().decode([Post].self, from: data)
        return response.count
        
    }
}

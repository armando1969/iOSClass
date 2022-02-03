//
//  ViewController.swift
//  FirstURLSession
//
//  Created by Consultant on 1/31/22.
//

import UIKit


class ViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    private let postNetwork = NetworkServices()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
         loadStories()
        loadPosts()
    }
    
    private func loadPosts() {
        
//        networkManager.getModel([Post].self, from: NetworkURLs.postsURL) { result  in
//            switch result {
//            case .success(let response):
//                let firstPost = response.first
//            //    print(firstPost?.title)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        //using service
//        postNetwork.get(from: NetworkURLs.postsURL) { result in
//            switch result {
//            case .success(let response):
//                let firstPost = response.first
//                print(firstPost?.title)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    private func loadStories() {
        
//        networkManager.getModel(RedditResponse.self, from: NetworkURLs.baseURLReddit) { result  in
//            switch result {
//            case .success(let response):
//                print(response.data.children.first?.data.title)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        postNetwork.get(from: NetworkURLs.baseURLReddit) { result in
            switch result {
            case .success(let response):
                //let firstPost = response.first
                print(response.data.children.first)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


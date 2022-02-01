//
//  ViewController.swift
//  FirstURLSession
//
//  Created by Consultant on 1/31/22.
//

import UIKit


class ViewController: UIViewController {
    
    private let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    private func loadData() {
        
        networkManager.getPosts(from: NetworkURLs.postsURL) { result  in
            switch result {
            case .success(let response):
                let firstPost = response.first
               // print(firstPost?.id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}


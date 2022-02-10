//
//  ViewController.swift
//  ComunicationExample
//
//  Created by Consultant on 2/8/22.
//

import UIKit
import Combine

var cache = [Post]()


class ViewController: UIViewController {
    
    private let viewModelProtocol = ViewModelProtocol()
    private let viewModelClosure = ViewModelClosure()
    private let viewModelCombine = ViewModelCombine()
    private var subscriber = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      //  setUpWithProtocol()
        dataBinding()
    }
    
    private func setUpWithProtocol() {
        viewModelProtocol.delegate = self
        viewModelProtocol.getPost()
        
        let totalPosts = viewModelProtocol.getPostsaWithoutThread()
        print("total posts: \(totalPosts)")
//        let title = cache.first?.title
//        print(title)
    }
    
    private func dataBinding()
    {
        viewModelCombine
            .$posts
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { posts  in
                print("combine publisher: \(posts.count)")
            })
            .store(in: &subscriber)
        viewModelCombine.getPosts()
    }


}

extension ViewController: ViewModelProtocolDelegate {
    func displayPosts(_ posts: [Post]) {
        cache = posts
       let title = cache.first?.title
        print(title!)
        
    }
}

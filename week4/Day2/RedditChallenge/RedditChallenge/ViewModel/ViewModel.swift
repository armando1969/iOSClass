//
//  ViewModel.swift
//  RedditChallenge
//
//  Created by Consultant on 2/13/22.
//

import Foundation
import Combine
import CoreVideo
import UIKit

class ViewModel {
    
    private let networkManager = NetworkManager()
    private var after = ""
    private var isLoading = false
    @Published private(set) var stories = [Story]()
    
    func getStories() {
        
        networkManager
            .getModel(RedditResponse.self, from: NetworkURL.baseURL) { [weak self] result in
                switch result {
                case .success(let response):
                    let children = response.data.children
                    var stories = [Story]()
                    for child in children {
                        stories.append(child.data)
                    }
                    self?.stories.append(contentsOf: stories)
                    self?.after = response.data.after
                    self?.isLoading = false
                    //  self?.stories = response.data.children.map { $0.data }
                      
                case .failure(let error):
                    self?.isLoading = false
                    print(error.localizedDescription)
                }
            }
    }
    
    func loadMoreStories() {
        
        let newURL = "\(NetworkURL.baseURL)?after=\(after)"
        networkManager
            .getModel(RedditResponse.self, from: newURL) { [weak self] result in
                switch result {
                case .success(let response):
                    let children = response.data.children
                    var stories = [Story]()
                    for child in children {
                        stories.append(child.data)
                    }
                    self?.stories.append(contentsOf: stories)
                    self?.after = response.data.after
                    self?.isLoading = false
                    //  self?.stories = response.data.children.map { $0.data }
                      
                case .failure(let error):
                    self?.isLoading = false
                    print(error.localizedDescription)
                }
            }
    }
    
    func getTitle(by row: Int) -> String {
        let story = stories[row]
        return story.title.capitalized
    }
    
    func getIdentifier(by row: Int) -> String {
        return "\(stories[row].id)"
    }
    
//    func getImage(by row: Int) -> UIImage {
//        return { UIImage }
//    }
    
}

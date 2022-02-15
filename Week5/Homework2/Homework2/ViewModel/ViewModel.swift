//
//  ViewModel.swift
//  Homework #2
//
//  Created by Consultant on 2/13/22.
//

import Foundation
import Combine

class ViewModel {
    
    private let networkManager = NetworkManager()
    private var after = ""
    private var isLoading = false
    @Published private(set) var movies = [Results]()
    
    func getMovies() {
        networkManager
            .getModel(Welcome.self, from: NetworkURL.baseMovieURL) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.movies = response.results.map { $0 }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
//    func loadMoreMovies() {
//        networkManager
//            .getModel(Welcome.self, from: NetworkURL.baseMovieURL) { [weak self] result in
//                switch result {
//                case .success(let response):
//                    let results = response.results
//                    var movies = [Results]()
//                    for result in results {
//                        movies.append(result)
//                    }
//                    self?.movies = movies
//                    print(movies.count)
//                    
//                    //  self?.movies = response.map { $0 }
//                      
//                case .failure(let error):
//                  //  self?.isLoading = false
//                    print(error.localizedDescription)
//                }
//            }
//    }
    
    func getTitle(by row: Int) -> String{
        let movie = movies[row]
        return movie.originalTitle.capitalized
    }
    
    func getOverview(by row: Int) -> String{
        let movie = movies[row]
        return movie.overview.localizedCapitalized
    }
}

//
//  ViewModel.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import Foundation
import Combine
import UIKit

class ViewModel {
    
    private let networkManager = NetworkManager()
    private var after = ""
    private var isLoading = false
    @Published private(set) var movies = [Results]()
    @Published private(set) var images = [Data]()
    
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
    
    
    func getTitle(by row: Int) -> String {
        let movie = movies[row]
        return movie.originalTitle.capitalized
    }
    
//    func getTitles() -> [String] {
//        var titles: [String] = []
//        print(movies.count)
//        for i in 0...(movies.count-1) {
//            titles[i] = movies[i].originalTitle
//            print(movies[i].originalTitle)
//        }
//        return [" ", " "]
//    }
    
    func getOverview(by row: Int) -> String {
        let movie = movies[row]
        return movie.overview.localizedCapitalized
    }
    
    func getImageData(by row: Int) -> Data? {
        let movie = movies[row]
        let path = "https://image.tmdb.org/t/p/original\(movie.posterPath)"
        let url = URL(string: path)
        if let data = try? Data(contentsOf: url!) {
            return data
        } else {
            return nil }
    }
}

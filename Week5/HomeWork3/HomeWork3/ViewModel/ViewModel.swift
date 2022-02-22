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
    @Published private(set) var companies = [ProductionCompany]()
    @Published private(set) var images = [Data]()
    
    func getMovies() {
        networkManager
            .getModel(MovieList.self, from: NetworkURL.baseMovieURL) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.movies = response.results.map { $0 }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func getProductionCompanies(id movieId: Int) {
        networkManager
            .getModel(Production.self, from: "\(NetworkURL.baseProductionURL)\(movieId)?api_key=6622998c4ceac172a976a1136b204df4&language=en-US") { [weak self] result in
                switch result {
                case .success(let response):
                    self?.companies = response.productionCompanies.map {$0}
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    
    func getTitle(by row: Int) -> String {
        let movie = movies[row]
        return movie.title.localizedCapitalized
    }
    
    func getOverview(by row: Int) -> String {
        let movie = movies[row]
      //  print(movie)
        return movie.overview.localizedCapitalized
    }
    
    func getProductionCo(by row: Int) -> String {
        let company = companies[row].name
        return company
    }
    
    func getMovieId(by row: Int) -> Int {
        let movie = movies[row]
        return movie.id
    }
//
//    func getProductionCo(by id: Int) -> [ProductionCompany] {
//        getProductionCompanies(id: id)
//        return companies
//    }
//
    func getProductionImageData(by row: Int) -> Data? {
        let company = companies[row]
        let path = "https://image.tmdb.org/t/p/original\(company.logoPath)"
        let url = URL(string: path)
        if let data = try? Data(contentsOf: url!) {
            return data
        } else {
            return nil }
    }
    
    func getMovieImageData(by row: Int) -> Data? {
        let movie = movies[row]
        let path = "https://image.tmdb.org/t/p/original\(movie.posterPath)"
        let url = URL(string: path)
        if let data = try? Data(contentsOf: url!) {
            return data
        } else {
            return nil }
    }
}

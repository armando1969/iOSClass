//
//  Presenter.swift
//  MVPExample
//
//  Created by Consultant on 2/4/22.
//

import Foundation

protocol MoviePresenterProtocol {
    func get()
    func getTitle(by row: Int) -> String?
    func getOverview(by row: Int) -> String?
    func getImage(by row: Int) -> Data?
    
    var rows: Int { get }
}

protocol MovieViewProtocol {
    func refreshTableView()
    func displayError(_ message: String)
}

class MoviePresenter: MoviePresenterProtocol {
    
    private let view: MovieViewProtocol
    private let networkManager: NetworkManager
    private var movie = [Movie]()
    private var cache = [Int: Data]()
    var rows: Int {
        return movie.count
    }
    
    init(view: MovieViewProtocol, networkManage: NetworkManager = NetworkManager()) {
        
        self.view = view
        self.networkManager = networkManage
    }
    
    func get() {
        let url = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=3&api_key=6622998c4ceac172a976a1136b204df4"
        networkManager.get(from: url) { [weak self] result in
            switch result {
                
            case .success(let response):
                self?.movie = response.results
                self?.downloadImages()
                DispatchQueue.main.async {
                    self?.view.refreshTableView()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view.displayError(error.localizedDescription)
                }
            }
        }
    }
    
    func getTitle(by row: Int) -> String? {
        return movie[row].originalTitle
    }
    
    func getOverview(by row: Int) -> String? {
        return movie[row].overview
    }
    func getImage(by row: Int) -> Data? {
        return cache[row]
    }
    
    private func downloadImages() {
        let baseImageURL = "https://image.tmdb.org/t/p/w500"
        let posterArray = movie.map { "\(baseImageURL)\($0.posterPath)"  }
    
        let group = DispatchGroup()
        group.enter()
        for (index, url) in posterArray.enumerated() {
            networkManager.getImageData(from: url) { [weak self] data in
                if let data = data {
                    self?.cache[index] = data
                }
            }
        }
        group.leave()
        group.notify(queue: .main) { [weak self] in
            self?.view.refreshTableView()
        }
    }
    
}

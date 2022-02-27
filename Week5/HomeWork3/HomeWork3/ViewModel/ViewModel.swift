//
//  ViewModel.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import Foundation
import Combine
import UIKit
import CoreData

class ViewModel {
    
    private let networkManager = NetworkManager()
    private var isLoading = false
    @Published private(set) var movies = [Movie]()
    @Published private(set) var companies = [ProductionCompany]()
    @Published private(set) var favoriteMovie = FavoriteMovie(id: 0, orginalTitle: "", overview: "", posterPath: "", isFavorite: false, favoriteIndex: -1)
    
    var favoriteMovies = [FavoriteMovie?]()
    private var movie = Movie()
    private var user = ""
    private var favoriteStatus = [Bool](repeating: false, count: 20)
    var favIndex = 0
    static let shared = ViewModel()
    
    func getMovies() {
        
        
        networkManager
            .getModel(MovieList.self, from: NetworkURL.baseMovieURL) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.movies = response.results.map { $0 }
                    self?.saveMovies()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func getProductionCompanies(id movieId: Int) {
        
        // I need to implement logic for if favorite has data
        networkManager
            .getModel(Production.self, from: "\(NetworkURL.baseProductionURL)\(movieId)?api_key=6622998c4ceac172a976a1136b204df4&language=en-US") { [weak self] result in
                switch result {
                case .success(let response):
                    self?.companies = response.productionCompanies.map {$0}
                    self?.saveMovies()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    private func saveMovies() {
        let context = CoreDataManager.shared.mainContext
        guard let entity = NSEntityDescription.entity(forEntityName: "CoreDataMovie", in: context)
        else {   return  }
        context.perform {
            for movie in self.favoriteMovies {
                let coreDataMovie = CoreDataMovie(entity: entity, insertInto: context)
                coreDataMovie.id = Int64(movie!.id)
                coreDataMovie.title = movie!.originalTitle
                coreDataMovie.overview = movie!.overview
                coreDataMovie.posterPath = movie!.posterPath
                coreDataMovie.isFavorite = false
                try? context.save()
            }
        }
    }
    
//    private func getAllCDMovies()  -> [Movie] {
//        let request: NSFetchRequest<CoreDataMovie> = CoreDataMovie.fetchRequest()
//        let context = CoreDataManager.shared.mainContext
//        context.perform {
//            let cDMovies = try? context.fetch(request)
//            var newMovies = [Movie]()
//        }
//    }
    
    
    
    func getImageData(_ path: String, completion: @escaping (Data?) -> Void)  {
        let url = URL(string: path)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    completion(data)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil) }
        }   }
    }
    
    func getMovie(by row: Int) -> Movie {
        let path = "https://image.tmdb.org/t/p/original\(movies[row].posterPath)"
        movie.id = movies[row].id
        movie.originalTitle = movies[row].originalTitle
        movie.overview = movies[row].overview
        movie.favoriteIndex = movies[row].favoriteIndex
        movie.posterPath = path
        movie.isFavorite = movies[row].isFavorite
            return movie
    }
    
    func getfavoriteMovie(by row: Int) -> FavoriteMovie {
        let path = "https://image.tmdb.org/t/p/original\(favoriteMovies[row]!.posterPath ?? "")"
        favoriteMovie.id = favoriteMovies[row]!.id
        favoriteMovie.originalTitle = favoriteMovies[row]!.originalTitle
        favoriteMovie.overview = favoriteMovies[row]!.overview
        favoriteMovie.posterPath = path
        favoriteMovie.isFavorite = movies[row].isFavorite
        print("in the VM the index for \(movies[row].originalTitle) is set to: \(movies[row].isFavorite)")
            return favoriteMovie
    }
    
    func setFavoriteMovie(id: Int, title: String, overview: String, posterPath: String, isFavorite: Bool) {
        print("in the Set the index for \(title) is set to: \(isFavorite)")
        favoriteMovie.id = id
        favoriteMovie.originalTitle = title
        favoriteMovie.overview = overview
        favoriteMovie.posterPath = posterPath
        for i in 0...(movies.count-1) {
            if movies[i].id == id {
                movies[i].isFavorite = isFavorite
            }
        }
        favoriteMovies.append(favoriteMovie)
    }
    
    func setUser(user: String) {
        self.user = user
    }
    
    func getUser() -> String {
        return user
    }
    
    func setIsfavorite(by row: Int, status: Bool) {
        movies[row].favoriteIndex = favIndex
        favIndex += 1
        favoriteStatus[row] = status
        //print("the index \(movies[row].originalTitle) is set to: \(movies[row].favoriteIndex)")
    }
    
    func getFavorite(by row: Int) -> Bool {
        return favoriteStatus[row]
    }
    
    func deleteFavoriteMovie(id: Int) {
        for i in 0...(favoriteMovies.count-1) {
//            print(i)
//        print("and we removed\(favoriteMovies[i]!.originalTitle) at: \(i)")
        favoriteMovies.remove(at: i)
        }
    }
}

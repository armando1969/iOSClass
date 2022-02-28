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
    @Published private(set) var favoriteMovie = FavoriteMovie(id: 0, originalTitle: "", overview: "", posterPath: "", favoriteIndex: -1)
    
    var favoriteMovies = [FavoriteMovie?]()
    private var movie = Movie(id: 0, originalTitle: "", overview: "", posterPath: "", isFavorite: false, favoriteIndex: -1)
    private var user = ""
    private var favoriteStatus = [Bool](repeating: false, count: 20)
    var favIndex = 0
    static let shared = ViewModel()
    
    func getMovies() {
        let currentMovies = getAllCDMovies()
        
        var forceUpdate = false
        let cacheTime = UserDefaults.standard.double(forKey: "cacheTime")
        let currentTime = Date().timeIntervalSince1970
        let time = currentTime - cacheTime
        if time >= 60 * 60 * 24 {
            forceUpdate = true  }
        
        if currentMovies.isEmpty || forceUpdate {
        cleanMovies()
        networkManager
            .getModel(MovieList.self, from: NetworkURL.baseMovieURL) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.movies = response.results.map { $0 }
                    self?.saveMovies()
                    UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "cacheTime")
                    UserDefaults.standard.synchronize()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }  else {
            movies = currentMovies
        }
    }
    
    private func cleanMovies() {
        let request: NSFetchRequest<CoreDataMovie> = CoreDataMovie.fetchRequest()
              let context = CoreDataManager.shared.mainContext
              context.performAndWait {
                  let cdMovies = try? context.fetch(request)
                  for cdMovie in (cdMovies ?? []) {
                      context.delete(cdMovie)
                      try? context.save()
                  }  }
    }
    
    func cleanFavoriteMovies() {
        let request: NSFetchRequest<CoreDataFavoriteMovies> = CoreDataFavoriteMovies.fetchRequest()
              let context = CoreDataManager.shared.mainContext
              context.performAndWait {
                  let cdFavMovies = try? context.fetch(request)
                  for cdMovie in (cdFavMovies ?? []) {
                      context.delete(cdMovie)
                      try? context.save()
                  }  }
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
    
    private func saveMovies() {
        let context = CoreDataManager.shared.mainContext
        guard let entity = NSEntityDescription.entity(forEntityName: "CoreDataMovie", in: context)
        else {   return  }
        context.perform {
            for movie in self.movies {
                let coreDataMovie = CoreDataMovie(entity: entity, insertInto: context)
                    coreDataMovie.id = Int64(movie.id)
                    coreDataMovie.title = movie.originalTitle
                    coreDataMovie.overview = movie.overview
                    coreDataMovie.posterPath = movie.posterPath
                    coreDataMovie.favoriteIndex = Int64(movie.favoriteIndex)
                    try? context.save()
            }
        }
    }
    
    private func getAllCDMovies() -> [Movie] {
        let request: NSFetchRequest<CoreDataMovie> = CoreDataMovie.fetchRequest()
        let context = CoreDataManager.shared.mainContext
        var newMovies = [Movie]()
            //alternatively you could use the map operator
        context.performAndWait {
            let cDMovies = try? context.fetch(request)
            for cDMovie in (cDMovies ?? []) {
                let tempMovie = cDMovie.createMovie()
                newMovies.append(tempMovie)
            }
        }
        return newMovies
    }
    
    func getFavoriteMovies() {
        let currentMovies = getAllFavoriteCDMovies()
        favoriteMovies = currentMovies
        for favMovies in favoriteMovies {
            for i in 0...(movies.count-1) {
                if favMovies?.id == movies[i].id {
                movies[i].favoriteIndex = favMovies!.favoriteIndex
                movies[i].isFavorite = true
                }
            }
        }
    }
    
    func saveFavoriteMovies() {
        let context = CoreDataManager.shared.mainContext
        guard let entity = NSEntityDescription.entity(forEntityName: "CoreDataFavoriteMovies", in: context)
        else {   return  }
        context.perform {
            for movie in self.movies {
                if movie.favoriteIndex != -1 {
                    let coreDataFavoriteMovie = CoreDataMovie(entity: entity, insertInto: context)
                    coreDataFavoriteMovie.id = Int64(movie.id)
                    coreDataFavoriteMovie.title = movie.originalTitle
                    coreDataFavoriteMovie.overview = movie.overview
                    coreDataFavoriteMovie.posterPath = movie.posterPath
                    coreDataFavoriteMovie.favoriteIndex = Int64(movie.favoriteIndex) }
                try? context.save()
            }
        }
    }
    
    private func getAllFavoriteCDMovies() -> [FavoriteMovie] {
        let request: NSFetchRequest<CoreDataFavoriteMovies> = CoreDataFavoriteMovies.fetchRequest()
        let context = CoreDataManager.shared.mainContext
        var newMovies = [FavoriteMovie]()
            //alternatively you could use the map operator
        context.performAndWait {
            let cDFavMovies = try? context.fetch(request)
            for cDMovie in (cDFavMovies ?? []) {
                let tempMovie = cDMovie.createFavoriteMovie()
                newMovies.append(tempMovie)
            }
        }
        return newMovies
    }
    
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
        
        let path = "https://image.tmdb.org/t/p/original\(favoriteMovies[row]!.posterPath)"
        favoriteMovie.id = favoriteMovies[row]!.id
        favoriteMovie.originalTitle = favoriteMovies[row]!.originalTitle
        favoriteMovie.overview = favoriteMovies[row]!.overview
        favoriteMovie.posterPath = path
        return favoriteMovie
    }
    
    func filterMovies(searchText: String) {
        
        if searchText.isEmpty {
            movies = getAllCDMovies()
            return
        }
        
        let request: NSFetchRequest<CoreDataMovie> = CoreDataMovie.fetchRequest()
        let predicateTitle = NSPredicate(format: "title CONTAINS[c] %@", searchText)
        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicateTitle])
        request.predicate = predicate
        
        let context = CoreDataManager.shared.mainContext
            
        context.performAndWait { [weak self] in
            if let cDMovies = try? context.fetch(request) {
                let moviesFiltered = cDMovies.map { $0.createMovie() }
                self?.movies = moviesFiltered
            }
        }
    }
    
    func setFavoriteMovie(id: Int, title: String, overview: String, posterPath: String, isFavorite: Bool) {
        favoriteMovie.id = id
        favoriteMovie.originalTitle = title
        favoriteMovie.overview = overview
        favoriteMovie.posterPath = posterPath
        for i in 0...19 {
            if movies[i].id == id  {
                movies[i].isFavorite = isFavorite
                movies[i].favoriteIndex = favIndex
                favoriteStatus[i] = isFavorite
                }
        }
        favIndex += 1
        favoriteMovies.append(favoriteMovie)
    }
    
    func setUser(user: String) {
        self.user = user
    }
    
    func getUser() -> String {
        return user
    }
    
    func getFavorite(by row: Int) -> Bool {
        return favoriteStatus[row]
    }
    
    func deleteFavoriteMovie(id: Int) {
        for j in 0...19 {
            if movies[j].id == id {
                movies[j].isFavorite = false
                movies[j].favoriteIndex = -1
            }
        }
        favIndex -= 1
        for i in 0...(favoriteMovies.count-1) {
            if favoriteMovies[i]!.id == id {
                favoriteMovies.remove(at: i)
                return
            }
        }
    }
}

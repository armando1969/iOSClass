//
//  CoreDataFavoriteMovies+Utils.swift
//  HomeWork3
//
//  Created by Consultant on 2/27/22.
//

import Foundation


extension CoreDataFavoriteMovies {
    
func createMovie() -> Movie {
    
    let id = Int(self.id)
    let originalTitle = self.title ?? ""
    let overview = self.overview ?? ""
    let posterPath = self.posterPath ?? ""
    let isFavorite = self.isFavorite
    let favoriteIndex = Int(self.favoriteIndex)
    
    return Movie(id: id, originalTitle: originalTitle, overview: overview, posterPath: posterPath, isFavorite: isFavorite, favoriteIndex: favoriteIndex)
}

}

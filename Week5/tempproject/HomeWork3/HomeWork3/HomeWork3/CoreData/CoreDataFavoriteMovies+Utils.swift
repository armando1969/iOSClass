//
//  CoreDataFavoriteMovies+Utils.swift
//  HomeWork3
//
//  Created by Consultant on 2/27/22.
//

import Foundation


extension CoreDataFavoriteMovies {
    
func createFavoriteMovie() -> FavoriteMovie {
    
    let id = Int(self.id)
    let originalTitle = self.title ?? ""
    let overview = self.overview ?? ""
    let posterPath = self.posterPath ?? ""
    let favoriteIndex = Int(self.favoriteIndex)
    
    return FavoriteMovie(id: id, originalTitle: originalTitle, overview: overview, posterPath: posterPath, favoriteIndex: favoriteIndex)
}

}

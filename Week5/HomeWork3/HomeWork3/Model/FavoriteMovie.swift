//
//  FavoriteMovies.swift
//  HomeWork3
//
//  Created by Consultant on 2/20/22.
//

import Foundation

struct FavoriteMovie: Codable {
    var id: Int
    var originalTitle: String
    var overview: String
    var posterPath: String
   // var isFavorite: Bool
    var favoriteIndex: Int
    
    init(id: Int, originalTitle: String, overview: String, posterPath: String, /*isFavorite: Bool,*/ favoriteIndex: Int) {
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
      //  self.isFavorite = isFavorite
        self.favoriteIndex = favoriteIndex
    }
}

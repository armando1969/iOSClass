//
//  FavoriteMovies.swift
//  HomeWork3
//
//  Created by Consultant on 2/20/22.
//

import Foundation

struct FavoriteMovies: Codable {
    var id: Int
    var originalTitle: String
    var overview: String
    var posterPath: Data
    var isFavorite: Bool = false
    
//    init(id: Int, orginalTitle: String, overview: String, posterPath: String, isFavorite: Bool) {
//        self.id = id
//        self.originalTitle = orginalTitle
//        self.overview = overview
//       // self.posterPath = posterPath
//        self.isFavorite = isFavorite
//    }
}

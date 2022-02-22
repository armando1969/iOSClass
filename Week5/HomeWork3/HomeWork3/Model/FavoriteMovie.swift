//
//  FavoriteMovies.swift
//  HomeWork3
//
//  Created by Consultant on 2/20/22.
//

import Foundation

struct FavoriteMovies: Codable {
    var id: Int
    var isFavorite: Bool
    var originalTitle: String
    var overview: String
    var posterPath: Data
}

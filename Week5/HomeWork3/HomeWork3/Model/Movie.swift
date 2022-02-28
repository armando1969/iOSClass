//
//  Movie.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import Foundation

struct Movie: Codable {
    var id: Int = 0
    var originalTitle: String = ""
    var overview: String = ""
    var posterPath: String = ""
    var isFavorite: Bool = false
    var favoriteIndex: Int = -1

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
    }
    
    init(id: Int, originalTitle: String, overview: String, posterPath: String, isFavorite: Bool, favoriteIndex: Int) {
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.isFavorite = isFavorite
        self.favoriteIndex = favoriteIndex
    }
}

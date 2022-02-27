//
//  CoreDataMovie+Utils.swift
//  HomeWork3
//
//  Created by Consultant on 2/22/22.
//

import Foundation

extension CoreDataMovie {

func CreateMovie() -> Movie {
    
    let id = Int(self.id)
    let originalTitle = self.title ?? ""
    let overview = self.overview ?? ""
    let posterPath = self.posterPath ?? ""
    
    return Movie(id: id, originalTitle: originalTitle, overview: overview, posterPath: posterPath, isFavorite: false, favoriteIndex: -1)
}

}

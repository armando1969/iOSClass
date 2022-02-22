//
//  Results.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import Foundation

struct Results: Codable {
    let id: Int
    let originalTitle: String
    let overview: String
    let posterPath: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case title
    }
}

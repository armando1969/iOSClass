//
//  MovieResponse.swift
//  MVPExample
//
//  Created by Consultant on 2/4/22.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

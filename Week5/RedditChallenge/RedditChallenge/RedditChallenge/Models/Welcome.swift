//
//  Welcome.swift
//  HomeWork #2
//
//  Created by Consultant on 2/14/22.
//

import Foundation

struct Welcome: Codable {
    let page: Int
    let results: [Results]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

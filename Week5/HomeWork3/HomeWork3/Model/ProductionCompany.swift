//
//  ProductionCompany.swift
//  HomeWork3
//
//  Created by Consultant on 2/18/22.
//

import Foundation

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String
    let name: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

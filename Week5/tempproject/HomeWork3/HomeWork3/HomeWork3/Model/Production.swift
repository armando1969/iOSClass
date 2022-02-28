//
//  Production.swift
//  HomeWork3
//
//  Created by Consultant on 2/18/22.
//

import Foundation

    struct Production: Codable {
        let productionCompanies: [ProductionCompany]
        
        enum CodingKeys: String, CodingKey {
            case productionCompanies = "production_companies"
        }
    }



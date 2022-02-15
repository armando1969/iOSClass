//
//  NetworkError.swift
//  HomeWork #2
//
//  Created by Consultant on 2/13/22.
//

import Foundation
import UIKit

enum NetworkError: Error, LocalizedError {
    case badURL
    case other(Error)
    
    var errorDescription: String? {
    switch self {
    case .badURL:
        return "This is a bad url"
    case .other(let error):
        return error.localizedDescription
    }
    }
}

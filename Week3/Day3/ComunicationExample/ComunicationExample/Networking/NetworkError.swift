//
//  NetworkError.swift
//  ComunicationExample
//
//  Created by Consultant on 2/8/22.
//

import Foundation

internal enum NetworkError: Error {
    case badURL
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad URL"
        case .other(let error):
            return error.localizedDescription
        }
    }
}

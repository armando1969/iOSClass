//
//  NetworkError.swift
//  MVPExample
//
//  Created by Consultant on 2/4/22.
//

import Foundation


enum NetworkError: Error {
    case badURL
    case other(Error)
}

//
//  Post.swift
//  ComunicationExample
//
//  Created by Consultant on 2/8/22.
//

import Foundation



struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


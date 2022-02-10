//
//  post.swift
//  PostApp
//
//  Created by Consultant on 2/9/22.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case overview = "body"
    }
}

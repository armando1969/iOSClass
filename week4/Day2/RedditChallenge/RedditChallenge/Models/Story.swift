//
//  Story.swift
//  RedditChallenge
//
//  Created by Consultant on 2/13/22.
//

import Foundation

struct Story: Codable {
    let id = UUID()
    let title: String
    let thumbnail: String
    let thumbnailHeight: Int?
    let score: Int
    let numComments: Int
        
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case thumbnailHeight = "thumbnail_height"
        case score
        case numComments = "num_comments"
    }
}

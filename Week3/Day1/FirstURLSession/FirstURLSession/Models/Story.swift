//
//  Story.swift
//  FirstURLSession
//
//  Created by Consultant on 1/31/22.
//

import Foundation

typealias Story = RedditResponse.DataRedditResponse.Child.Story

struct RedditResponse: Codable {
    let data: DataRedditResponse
    struct DataRedditResponse: Codable {
        let children: [Child]
        struct Child:Codable {
            let data: Story
            struct Story: Codable {
                let authorFullname: String
                let title: String
                
                enum CodingKeys: String, CodingKey {
                    case title = "title"
                    case authorFullname = "author_fullname"
                }
            }
        }
}
}

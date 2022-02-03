//
//  Story.swift
//  FirstURLSession
//
//  Created by Consultant on 1/31/22.
//

import Foundation

typealias Story = RedditResponse.DataRedditResponse.Child.Story

struct RedditResponse: Decodable {
    let data: DataRedditResponse
    struct DataRedditResponse: Decodable {
        let children: [Child]
        struct Child: Decodable {
            let data: Story
            struct Story: Decodable {
                let title: String
            }
        }
}
}

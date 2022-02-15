//
//  RedditData.swift
//  RedditChallenge
//
//  Created by Consultant on 2/13/22.
//

import Foundation

struct RedditData: Codable {
    let after: String
    let children: [Child]
}
  

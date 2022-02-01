//
//  Model.swift
//  FirstURLSession
//
//  Created by Consultant on 1/31/22.
//

import Foundation
import UIKit

struct Post: Decodable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
 /*  static func parse(from dictionary: [String: Any]) -> Post {
       let userID = (dictionary["userId"] as? Int) ?? 0
        let id = (dictionary["id"] as? Int) ?? 0
        let title = (dictionary["title"] as? String) ?? ""
        let body = (dictionary["body"] as? String) ?? "" 
        
        return Post(userID: userID, id: id, title: title, body: body)
    } */
    
}

//
//  Model.swift
//  HomeWork
//
//  Created by Consultant on 1/31/22.
//

import Foundation
import UIKit

typealias NasaPhotos = Nasa.NasaPhotos

struct Nasa: Codable {
    
    let photos: [NasaPhotos]
    
    struct NasaPhotos: Codable {
        let id: Int
        let sol: Int
        let camera: Camera
        struct Camera: Codable {
            let id: Int
            let name: String
            let rover_id: Int
            let full_name: String
        }
        let img_src: String
        let earth_date: String
        let rover: Rover
        struct Rover: Codable {
            let id: Int
            let name: String
            let landing_date: String
            let launch_date: String
            let status: String
        }
    }
}

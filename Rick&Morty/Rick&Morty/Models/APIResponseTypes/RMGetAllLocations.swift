//
//  RMGetLocations.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 15.04.2023.
//

import Foundation

struct RMGetAllLocations: Codable {
    struct Info: Codable {
        let count, pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMLocation]
}

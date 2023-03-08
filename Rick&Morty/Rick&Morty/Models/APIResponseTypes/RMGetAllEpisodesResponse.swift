//
//  RMGetAllEpisodesResponse.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 05.03.2023.
//

import Foundation

struct RMGetAllEposodesResponse: Codable {
    struct Info: Codable {
        let count, pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
}



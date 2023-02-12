//
//  RMEpisode.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 10.02.2023.
//

import Foundation

    // MARK: - Result
    struct RMEpisodes: Codable {
        let id: Int
        let name, airDate, episode: String
        let characters: [String]
        let url: String
        let created: String

        enum CodingKeys: String, CodingKey {
            case id, name
            case airDate = "air_date"
            case episode, characters, url, created
        }
    }

//
//  RMGetAllCharactersResponse.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 14.02.2023.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count, pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}




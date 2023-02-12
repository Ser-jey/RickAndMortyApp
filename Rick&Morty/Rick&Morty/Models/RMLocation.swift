//
//  RMLocation.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 10.02.2023.
//

import Foundation

// MARK: - Result
struct RMLocation: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}

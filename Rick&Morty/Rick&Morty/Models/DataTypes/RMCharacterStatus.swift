//
//  RMCharacterStatus.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 12.02.2023.
//

import Foundation

// MARK: - Status
enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown" // чтобы не было путаницы у компилятора
    
    var text: String {
        switch self {
        case .alive, .dead:
            return self.rawValue
        case .unknown:
            return "Unknown"
        }
    }
}

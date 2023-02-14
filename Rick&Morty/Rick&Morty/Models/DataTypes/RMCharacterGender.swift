//
//  RMCharacterGender.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 12.02.2023.
//

import Foundation

enum RMCharacterGender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case `unknown` = "unknown"
}

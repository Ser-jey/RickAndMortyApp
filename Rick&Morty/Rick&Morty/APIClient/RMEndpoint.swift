//
//  RMEndpoint.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 11.02.2023.
//

import Foundation

/// Represent unique API endpoint
@frozen enum RMEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}


//
//  RMLocationTableViewCellViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 15.04.2023.
//

import Foundation

final class RMLocationTableViewCellViewModel: Hashable, Equatable {
   
    
    
    private let location: RMLocation
    
    init(location: RMLocation) {
        self.location = location
    }
    
    var name: String {
        return location.name
    }
    
    var type: String {
        return location.type
    }
    
    var dimension: String {
        return location.dimension
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(location.name)
        hasher.combine(location.dimension)
        hasher.combine(location.type)
        hasher.combine(location.id)
    }
    
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
}



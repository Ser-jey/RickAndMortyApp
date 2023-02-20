//
//  RMCharacterDetailViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 19.02.2023.
//

import Foundation

final class RMCharacterDetailViewModel {
    
    let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}

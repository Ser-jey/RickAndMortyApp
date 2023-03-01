//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 28.02.2023.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodesURL: URL?
    init(episodeURL: URL?) {
        self.episodesURL = episodeURL
    }
}

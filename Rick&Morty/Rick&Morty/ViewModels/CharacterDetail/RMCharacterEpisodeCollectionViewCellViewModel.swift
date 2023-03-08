//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 28.02.2023.
//

import UIKit

protocol RMEpisodeDataRender {
    var name: String { get }
    var airDate: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel: Hashable, Equatable {

    private let episodesURL: URL?
    private var isFetching = false // это переменная нужна для оптимизации загрузки данных из-за особенностей работы CollectionView

    private var dataBlock: ((RMEpisodeDataRender)->Void)?
    
    public let borderColor: UIColor
    
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    // MARK: - Init
    
    init(episodeURL: URL?, borderColor: UIColor = .systemBlue) {
        self.episodesURL = episodeURL
        self.borderColor = borderColor
    }
    
    public func registerForData(block: @escaping(RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisodes() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        guard let url = episodesURL,
              let request = RMRequest(url: url) else { return }
      
        isFetching = true
        
        RMService.shared.execute(request, expecning: RMEpisode.self) { [weak self] result in
            switch result {
                
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let error):
                break
            }
        }
    }
    // MARK: - Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodesURL?.absoluteString ?? "")
    }
    
    static func == (lhs: RMCharacterEpisodeCollectionViewCellViewModel, rhs: RMCharacterEpisodeCollectionViewCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    
}

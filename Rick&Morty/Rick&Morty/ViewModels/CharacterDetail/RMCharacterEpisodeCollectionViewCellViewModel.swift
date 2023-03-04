//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 28.02.2023.
//

import Foundation

protocol RMEpisodeDataRender {
    var name: String { get }
    var airDate: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodesURL: URL?
    private var isFetching = false
    private var dataBlock: ((RMEpisodeDataRender)->Void)?
    
    private var episode: RMEpisodes? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    // MARK: - Init
    
    init(episodeURL: URL?) {
        self.episodesURL = episodeURL
    }
    
    public func registerForData(block: @escaping(RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisodes() {
        // это переменная нужна для оптимизации загрузки данных из-за особенностей работы CollectionView
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        guard let url = episodesURL,
              let request = RMRequest(url: url) else { return }
      
        isFetching = true
        
        RMService.shared.execute(request, expecning: RMEpisodes.self) { [weak self] result in
            switch result {
                
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

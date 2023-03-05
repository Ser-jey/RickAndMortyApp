//
//  RMEpisodeDetailViewViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 05.03.2023.
//

import Foundation

final class RMEpisodeDetailViewViewModel {
    
    private let endpointUrl: URL?
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecning: RMEpisodes.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                break
            }
        }
    }
    
}

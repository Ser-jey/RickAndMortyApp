//
//  RMLocationViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 15.04.2023.
//

import Foundation

protocol RMLocationViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}

final class RMLocationViewModel {
    
    weak var delegate: RMLocationViewModelDelegate?
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location )
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    // Location response info
    // Will contain next url, if present
    private var apiInfo: RMGetAllLocations.Info?
    
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
    
    init() {}
    
    public func fetchLocations() {
        RMService.shared.execute(.listLocationsResult, expecning: RMGetAllLocations.self) { [weak self] result in
            switch result {
                
            case .success(let data):
                DispatchQueue.main.async {
                    self?.locations = data.results
                    self?.apiInfo = data.info
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private var hasMoreResult: Bool {
        return false
    }
    
}

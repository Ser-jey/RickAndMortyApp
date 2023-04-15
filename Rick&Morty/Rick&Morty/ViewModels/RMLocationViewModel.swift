//
//  RMLocationViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 15.04.2023.
//

import Foundation

final class RMLocationViewModel {
    
    private var locations: [RMLocation] = []
    
    // Location response info
    // Will contain next url, if present
    
    private var cellViewModels: [String] = []
    
    
    init() {}
    
    public func fetchLocations() {
        RMService.shared.execute(.listLocationsResult, expecning: [RMLocation].self) { result in
            switch result {
                
            case .success(let data):
                self.locations = //
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private var hasMoreResult: Bool {
        return false
    }
    
}

//
//  RMService.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 11.02.2023.
//

import Foundation


/// Primary API service object to get Rick and Morty data
final class RMService {
    
    /// Shared singleton instanse
    static let shared = RMService()
    
    /// Privatized constructor
    private init(){}
    
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request insatance
    ///   - type: The type of object  we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(_ request: RMRequest, expecning type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
    }
    
}

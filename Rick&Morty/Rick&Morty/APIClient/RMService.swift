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
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
        case failedToDecodeData
    }
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request insatance
    ///   - type: The type of object  we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(_ request: RMRequest, expecning type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            do {
            
                let result = try JSONDecoder().decode(type.self, from: data)
               
                completion(.success(result))
            } catch {
                completion(.failure(RMServiceError.failedToDecodeData))
            }
            
        }
        task.resume()
        
    }
 
    
   
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
    
}

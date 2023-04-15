//
//  RMRequest.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 11.02.2023.
//

import Foundation

/// Object that represents a single API Call
final class RMRequest {
    
    /// API Constans
    private struct Constans {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    public let endpoint: RMEndpoint
    
    /// Path component for API, if any
    private let pathComponent: [String]
    
    /// Query argwments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constans.baseURL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponent.isEmpty {
            pathComponent.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            // ?name=value$name=value
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return "" }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        
        return string
    }
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired httpMethod
    public let httpMethod = "GET"
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponent: Collection of Path components
    ///   - queryParameters: Collection of query parameters
    init(
        endpoint: RMEndpoint,
        pathComponent: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponent = pathComponent
        self.queryParameters = queryParameters
    }
    
    /// Attempt to create request
    /// - Parameter url: URL to parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constans.baseURL) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constans.baseURL + "/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] // Endpoint
                var pathComponent: [String] = []
                if components.count > 1 {
                    pathComponent = components
                    pathComponent.removeFirst()
                }
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, pathComponent: pathComponent)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemString = components[1]
                // value=name&value=name
                let queryItems: [URLQueryItem] = queryItemString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else { return nil }
                    
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
    
   
}

extension RMRequest {
    static let listCharactersResult = RMRequest(endpoint: .character)
    static let listEpisodesResult = RMRequest(endpoint: .episode)
    static let listLocationsResult = RMRequest(endpoint: .location)
}

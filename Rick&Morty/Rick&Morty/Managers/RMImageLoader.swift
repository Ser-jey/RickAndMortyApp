//
//  ImageLoader.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 24.02.2023.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    var cacheImageData = NSCache<NSString, NSData>()
    
    private init() {}
    
    /// Get image content with URL
    /// - Parameters:
    ///   - url: Source url
    ///   - completion: callback 
    func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = self.cacheImageData.object(forKey: key) {
            print("Cache image")
            completion(.success(data as Data))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self?.cacheImageData.setObject(value, forKey: key)
            print("Download Image")
            completion(.success(data))
            
        }
        task.resume()
    }
    
}

//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 28.02.2023.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    
    private let imageURL: URL?
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    public func getImageData(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url =  imageURL else {
            completion(.failure(URLError.badURL as! Error))
            return
        }
        RMImageLoader.shared.downloadImage(url, completion: completion)
    }
}

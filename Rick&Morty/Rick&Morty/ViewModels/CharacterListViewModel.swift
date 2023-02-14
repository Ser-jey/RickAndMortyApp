//
//  CharacterListViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 14.02.2023.
//

import UIKit

final class CharacterListViewModel: NSObject {
    
    func fetchCharacter() {
        RMService.shared.execute(.listCharacterResult, expecning: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total:" + String(model.info.count))
                print("Page result count:" + String(model.results.count))
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
}

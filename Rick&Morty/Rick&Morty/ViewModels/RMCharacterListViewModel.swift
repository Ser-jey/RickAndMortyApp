//
//  CharacterListViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 14.02.2023.
//

import UIKit

final class RMCharacterListViewModel: NSObject {
    
    private var characters: [RMCharacter] = [] {
        didSet {
            characters.forEach({
                let viewModel = RMCharacterCollectionViewCellModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageURL: URL(string: $0.image)
                )
                cellViewModels.append(viewModel)
            })
            
        }
    }
    
    var cellViewModels: [RMCharacterCollectionViewCellModel] = []
    
    func fetchCharacter() {
        RMService.shared.execute(.listCharacterResult, expecning: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                let results = model.results
                self?.characters = results
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension RMCharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath)
         as? RMCharacterCollectionViewCell else { fatalError("Usupported cell")}
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
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

//
//  CharacterListViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 14.02.2023.
//

import UIKit

protocol RMCharacterListViewModelDelegate: NSObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    
    func didSelectCharacter(_ character: RMCharacter)
}

/// View Model to handle character list view logic
final class RMCharacterListViewModel: NSObject {
    
    weak var delegate: RMCharacterListViewModelDelegate?
    
    private var isLoadingMoreCharacters: Bool = false
    
    private var characters: [RMCharacter] = [] {
        didSet {
            characters.forEach({
                let viewModel = RMCharacterCollectionViewCellModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageURL: URL(string: $0.image)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            })
            
        }
    }
    
    var cellViewModels: [RMCharacterCollectionViewCellModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    /// Fetch initial set of characters (20)
    func fetchCharacter() {
        RMService.shared.execute(.listCharacterResult, expecning: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                let results = model.results
                let info = model.info
                self?.apiInfo = info
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalCharacters(url: URL) {
        // Fetch characters
        guard !isLoadingMoreCharacters else { return }
        isLoadingMoreCharacters = true
        print(url)
        guard let request = RMRequest(url: url) else { return }
        print("Should start fetching more")
        RMService.shared.execute(
                request,
                expecning: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
                
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                print(moreResults[0].name)
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let totalCount = originalCount + newCount
                let startingIndex = totalCount - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                print(indexPathsToAdd)
                strongSelf.characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
}

// MARK: - CollectionView

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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
            for: indexPath) as? RMFooterLoadingCollectionReusableView  else {
            fatalError("Unsupported")
        }
        footer.startAnimationg()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(
            width: collectionView.frame.width,
            height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

// MARK: - ScrollView

extension RMCharacterListViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              let nextURLString = apiInfo?.next ,
              let url = URL(string: nextURLString),
              !cellViewModels.isEmpty
              else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedSize = scrollView.frame.size.height
           
            if offset > (totalContentHeight - totalScrollViewFixedSize - 120) && offset > 0 {
                self?.fetchAdditionalCharacters(url: url)
            }
            t.invalidate()
        }
    }
}

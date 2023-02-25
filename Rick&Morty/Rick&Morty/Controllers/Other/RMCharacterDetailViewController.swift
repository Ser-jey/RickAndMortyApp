//
//  RMCharacterDetailViewController.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 19.02.2023.
//

import UIKit

/// Controller to show info about single character
final class RMCharacterDetailViewController: UIViewController {

    private let viewModel: RMCharacterDetailViewModel
    
    private let detailView: RMCharacterDetailView
    
    // MARK: - Init
    init(viewModel: RMCharacterDetailViewModel) {
        self.viewModel = viewModel
        detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        addConstraints()
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    @objc
    private func didTapShare() {
        // some code
    }
    

    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: - CollectionView

extension RMCharacterDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink
        }
        else if indexPath.section == 1 {
            cell.backgroundColor = .systemGreen
        }
        else {
            cell.backgroundColor = .systemBlue
        }
        return cell
    }
    
    
    
    
    
}

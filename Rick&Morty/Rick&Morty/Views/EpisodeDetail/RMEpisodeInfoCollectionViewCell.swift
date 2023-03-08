//
//  RMEpisodeInfoCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 08.03.2023.
//

import UIKit

final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMEpisodeInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("Usupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    public func configure(with viewModel: RMEpisodeInfoCollectionViewCellViewModel) {
        
    }
}

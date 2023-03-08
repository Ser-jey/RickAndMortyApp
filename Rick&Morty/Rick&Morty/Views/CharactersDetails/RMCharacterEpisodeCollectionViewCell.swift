//
//  RMCharacterEpisodeCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 28.02.2023.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentier = "RMCharacterEpisodeCollectionViewCell"
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let namelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let datelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        setUpLayer()
        contentView.addSubviews(seasonLabel, namelabel, datelabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            namelabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            namelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            namelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            namelabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            datelabel.topAnchor.constraint(equalTo: namelabel.bottomAnchor),
            datelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            datelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            datelabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        namelabel.text = nil
        datelabel.text = nil
    }
    
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
           
            self?.datelabel.text = "Aired on " + data.airDate
            self?.seasonLabel.text = "Episode " + data.episode
            self?.namelabel.text = data.name
        }
        viewModel.fetchEpisodes()
        contentView.layer.borderColor = viewModel.borderColor.cgColor
    }
    
}

//
//  RMLocationTableViewCell.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 15.04.2023.
//

import UIKit

final class RMLocationTableViewCell: UITableViewCell {

    static let cellIdentifire = "RMLocationTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        
    }
    
}

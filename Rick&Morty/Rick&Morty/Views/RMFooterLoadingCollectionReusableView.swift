//
//  RMFooterLoadingCollectionReusableView.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 19.02.2023.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
     static let identifier = "RMFooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    public func startAnimationg() {
        spinner.startAnimating()
    }
}

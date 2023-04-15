//
//  RMLocationsViewController.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 10.02.2023.
//

import UIKit

/// Controller to show and search Locations
final class RMLocationsViewController: UIViewController {

    private let primaryView = RMLocationView()
    
    private let viewModel = RMLocationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(primaryView)
        view.backgroundColor = .systemBackground
        title = "Locations"
        addConstraints()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            primaryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

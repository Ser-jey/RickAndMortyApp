//
//  RMEpisodeDetailViewController.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 04.03.2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {

    private let viewModel: RMEpisodeDetailViewViewModel
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .green
    }

    init(url: URL?) {
        viewModel = RMEpisodeDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Usupported")
    }
    
}

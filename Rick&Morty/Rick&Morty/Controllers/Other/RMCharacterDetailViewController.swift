//
//  RMCharacterDetailViewController.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 19.02.2023.
//

import UIKit

/// Controller to show info about single character
final class RMCharacterDetailViewController: UIViewController {

    var viewModel: RMCharacterDetailViewModel
    
    init(viewModel: RMCharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    


}

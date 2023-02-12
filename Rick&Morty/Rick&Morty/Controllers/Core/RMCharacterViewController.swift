//
//  RMCharacterViewController.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 10.02.2023.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = RMRequest(endpoint: .character,
                                queryParameters: [
                                    URLQueryItem(name: "name", value: "rick"),
                                    URLQueryItem(name: "status", value: "alive")
                                ]
        )
        
        RMService.shared.execute(request, expecning: RMCharacter.self) { result in
            
        }
    }
}

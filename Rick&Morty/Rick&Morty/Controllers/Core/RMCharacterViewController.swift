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
        

        RMService.shared.execute(.listCharacterResult, expecning: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total:" + String(model.info.count))
                print("Page result count:" + String(model.results.count))
            case .failure(let error):
                print(error)
            }
        }
        
        print(RMRequest.listCharacterResult.url)
        
    }
}

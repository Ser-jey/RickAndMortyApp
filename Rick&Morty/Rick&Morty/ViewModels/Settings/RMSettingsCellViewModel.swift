//
//  RMSettingsCellViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 23.03.2023.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable {
    var id = UUID()
    
    
    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void
    
    // MARK: - Init
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    // MARK: - Public
    public var image: UIImage? {
        return type.icomImage
    }
    public var title: String {
        return type.displayTitel
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
}

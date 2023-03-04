//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 28.02.2023.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    private let value: String
    private let type: `Type`
    
    public var title: String {
        return type.displayTitle.uppercased()
    }
 
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.timeZone = .current
        return formatter
    }()
    public var displayValue: String {
        if value.isEmpty { return "None" }
        if type == .created {
            if let date = Self.dateFormatter.date(from: value) {
                return Self.shortDateFormatter.string(from: date)
            }
        }
        return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    enum `Type` {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episode
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemPurple
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            case .location:
                return .systemPink
            case .created:
                return .systemYellow
            case .episode:
                return .systemMint
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .episode:
                return UIImage(systemName: "bell")
            }
        }
        
        public var displayTitle: String {
            switch self {
            case .status:
                return "Status"
            case .gender:
                return "Gender"
            case .type:
                return "Type"
            case .species:
                return "Species"
            case .origin:
                return "Origin"
            case .location:
                return "Location"
            case .created:
                return "Created"
            case .episode:
                return "Episode"
            }
        }
    }
    

    
    init(type: `Type`, value: String) {
        self.value = value
        self.type = type
    }
}

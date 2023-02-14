//
//  Extensions.swift
//  Rick&Morty
//
//  Created by Сергей Кривошеев on 14.02.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}


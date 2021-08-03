//
//  Color.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 03/08/2021.
//

import UIKit

enum Color {
    case background(variant: ColorVariant)
    case text(variant: ColorVariant)
}

enum ColorVariant {
    case dark
    case light
    case regular
}

extension Color: UIColorConvertible {
    func uiColor(with alpha: CGFloat = 1) -> UIColor {
        switch self {
        case .background(let variant):
            switch variant {
            case .dark:
                return UIColor(red: 0/255, green: 5/255, blue: 5/255, alpha: alpha)
            case .light:
                return UIColor(red: 40/255, green: 45/255, blue: 45/255, alpha: alpha)
            case .regular:
                return UIColor(red: 20/255, green: 25/255, blue: 25/255, alpha: alpha)
            }
        case .text(let variant):
            switch variant {
            case .dark:
                return UIColor(red: 120/255, green: 245/255, blue: 245/255, alpha: alpha)
            case .light:
                return UIColor(red: 220/245, green: 255/255, blue: 255/255, alpha: alpha)
            case .regular:
                return UIColor(red: 180/255, green: 255/255, blue: 255/255, alpha: alpha)
            }
        }
    }
}

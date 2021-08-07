//
//  Font.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 07/08/2021.
//

import UIKit

enum Font {
    case primary
}

extension Font: UIFontConvertible {
    func uiFont(with size: CGFloat) -> UIFont {
        switch self {
        case .primary:
            return .systemFont(ofSize: size)
        }
    }
}

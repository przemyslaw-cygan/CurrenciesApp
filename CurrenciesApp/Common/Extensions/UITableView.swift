//
//  UITableView.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 11/08/2021.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withIdentifier identifier: String, for indexPath: IndexPath) -> T {
        (dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T) ?? T()
    }
}

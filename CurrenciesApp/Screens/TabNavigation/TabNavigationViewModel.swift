//
//  TabNavigationViewModel.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 07/08/2021.
//

import RxSwift
import RxCocoa

enum TabNavigationViewModelError: Error {
    case selectedIndexOutOfBounds
}

protocol TabNavigationViewModel {
    var selectedIndex: Driver<Int?> { get }
    var selectedViewController: Driver<TabNavigationAdaptable?> { get }
    var viewControllers: Driver<[TabNavigationAdaptable]> { get }

    func selectIndex(_ index: Int?)
    func setViewControllers(_ viewControllers: [TabNavigationAdaptable])
}

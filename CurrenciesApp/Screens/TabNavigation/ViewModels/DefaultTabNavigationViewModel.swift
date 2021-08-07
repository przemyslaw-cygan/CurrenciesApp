//
//  DefaultTabNavigationViewModel.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 07/08/2021.
//

import RxSwift
import RxCocoa

class DefaultTabNavigationViewModel {
    private let selectedIndexSubject: BehaviorSubject<Int?>
    private let viewControllersSubject: BehaviorSubject<[TabNavigationAdaptable]>

    init(with initialViewControllers: [TabNavigationAdaptable]) {
        self.selectedIndexSubject = .init(value: initialViewControllers.indices.first)
        self.viewControllersSubject = .init(value: initialViewControllers)
    }
}

extension DefaultTabNavigationViewModel: TabNavigationViewModel {
    var selectedIndex: Driver<Int?> {
        selectedIndexSubject
            .withLatestFrom(viewControllers) { try Self.sanitize(index: $0, for: $1) }
            .asDriver(onErrorJustReturn: nil)
    }

    var selectedViewController: Driver<TabNavigationAdaptable?> {
        selectedIndexSubject
            .withLatestFrom(viewControllers) { try Self.sanitize(index: $0, for: $1) }
            .asDriver(onErrorJustReturn: nil)
    }

    var viewControllers: Driver<[TabNavigationAdaptable]> {
        viewControllersSubject.asDriver(onErrorJustReturn: [])
    }

    func selectIndex(_ index: Int?) {
        selectedIndexSubject.onNext(index)
    }

    func setViewControllers(_ viewControllers: [TabNavigationAdaptable]) {
        viewControllersSubject.onNext(viewControllers)
        selectedIndexSubject.onNext(viewControllers.indices.first)
    }
}

private extension DefaultTabNavigationViewModel {
    static func sanitize(index: Int?, for viewControllers: [TabNavigationAdaptable]) throws -> Int? {
        guard let index = index else { return nil }
        guard viewControllers.indices.contains(index) else {
            throw TabNavigationViewModelError.selectedIndexOutOfBounds
        }
        return index
    }

    static func sanitize(index: Int?, for viewControllers: [TabNavigationAdaptable]) throws -> TabNavigationAdaptable? {
        guard let index = index else { return nil }
        guard viewControllers.indices.contains(index) else {
            throw TabNavigationViewModelError.selectedIndexOutOfBounds
        }
        return viewControllers[index]
    }
}

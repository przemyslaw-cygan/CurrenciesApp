//
//  MockListViewModel.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 11/08/2021.
//

import RxSwift
import RxCocoa

class MockListViewModel {
    private let mockCurrencies = [
        Currency(symbol: "USD", name: "United States Dollar"),
        Currency(symbol: "AED", name: "United Arab Emirates Dirham"),
        Currency(symbol: "AFN", name: "Afghan Afghani"),
        Currency(symbol: "ALL", name: "Albanian Lek")
    ]
}

extension MockListViewModel: ListViewModel {
    var sections: Driver<[ListSection]> {
        Driver.just([
            .currenciesSection(title: "currencies", items: mockCurrencies.map { .currencyInfo(currency: $0) })
        ])
    }
}

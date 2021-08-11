//
//  CurrencyRate.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 11/08/2021.
//

import Foundation

struct CurrencyRate {
    let currency: Currency
    let baseCurrency: Currency
    let rate: Double
}

extension CurrencyRate: Identifiable {
    var id: String { "\(currency.symbol)_\(baseCurrency.symbol)" }
}

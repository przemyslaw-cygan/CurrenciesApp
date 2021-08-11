//
//  CurrencyHistory.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 11/08/2021.
//

import Foundation

struct CurrencyRateTimeSeries {
    let currency: Currency
    let baseCurrency: Currency
    let startDate: Date
    let endDate: Date
    let rates: [Date: Double]
}

extension CurrencyRateTimeSeries: Identifiable {
    var id: String {
        let startId = "\(startDate.timeIntervalSince1970)"
        let endId = "\(endDate.timeIntervalSince1970)"
        return "\(currency.symbol)_\(baseCurrency.symbol)_\(startId)_\(endId)"
    }
}

//
//  Currency.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 11/08/2021.
//

import Foundation

struct Currency {
    let symbol: String
    let name: String
}

extension Currency: Identifiable {
    var id: String { symbol }
}

//
//  ListSectionItem.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 11/08/2021.
//

import RxDataSources

enum ListSectionItem {
    case currencyInfo(currency: Currency)
}

extension ListSectionItem: IdentifiableType, Equatable {
    typealias Identity = String

    var identity: String {
        switch self {
        case .currencyInfo(let currency):
            return currency.id
        }
    }

    static func == (lhs: ListSectionItem, rhs: ListSectionItem) -> Bool {
        lhs.identity == rhs.identity
    }
}

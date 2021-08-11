//
//  ListSection.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 11/08/2021.
//

import RxDataSources

enum ListSection {
    case currenciesSection(title: String, items: [Item])
}

extension ListSection: IdentifiableType {
    typealias Identity = String

    var identity: String {
        switch self {
        case .currenciesSection(let title, _):
            return title
        }
    }
}

extension ListSection: AnimatableSectionModelType {
    typealias Item = ListSectionItem

    var items: [ListSectionItem] {
        switch self {
        case .currenciesSection(_, let items):
            return items.map { $0 }
        }
    }

    init(original: ListSection, items: [Item]) {
        switch original {
        case .currenciesSection(let title, _):
            self = .currenciesSection(title: title, items: items)
        }
    }
}

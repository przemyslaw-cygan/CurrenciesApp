//
//  ListViewModel.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 11/08/2021.
//

import RxSwift
import RxCocoa

protocol ListViewModel {
    var sections: Driver<[ListSection]> { get }
}

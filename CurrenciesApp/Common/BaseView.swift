//
//  BaseView.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 07/08/2021.
//

import UIKit

class BaseView: UIView, UIViewBuilder, UIViewBinder {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewHierarchy() {}
    func setupViewAutolayout() {}
    func setupViewProperties() {}
    func bindView() {}

    private func setup() {
        setupViewHierarchy()
        setupViewAutolayout()
        setupViewProperties()
        bindView()
    }

}

//
//  BaseViewController.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 07/08/2021.
//

import UIKit
import RxSwift

class BaseViewController<ViewModel>: UIViewController, UIViewBuilder, UIViewBinder {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    let disposeBag = DisposeBag()
    let viewModel: ViewModel

    func setupViewHierarchy() {}
    func setupViewAutolayout() {}
    func setupViewProperties() {}
    func bindView() {}
    func bindViewModel() {}

    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setupViewHierarchy()
        setupViewAutolayout()
        setupViewProperties()
        bindView()
        bindViewModel()
    }

}

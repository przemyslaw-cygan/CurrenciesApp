//
//  TabNavigationViewController.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 07/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class TabNavigationViewController: BaseViewController<TabNavigationViewModel> {

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    private var items = [TabNavigationItem]() {
        didSet { update(currentItems: items, previousItems: oldValue) }
    }

    private let mainNavigationController = UINavigationController()
    private let itemsView = UIView()
    private let itemsWrapperView = UIView()
    private let itemsStackView = UIStackView()

    private var itemTapDisposeBag = DisposeBag()
    private let itemTapSubject = PublishSubject<Int>()

    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        view.addSubview(mainNavigationController.view)
        view.addSubview(itemsView)
        itemsView.addSubview(itemsWrapperView)
        itemsWrapperView.addSubview(itemsStackView)
    }

    override func setupViewAutolayout() {
        super.setupViewAutolayout()

        mainNavigationController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(itemsView.snp.top)
        }

        itemsView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }

        itemsWrapperView.snp.makeConstraints {
            $0.top.bottom.equalTo(itemsView.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(itemsView.safeAreaLayoutGuide).inset(10)
        }

        itemsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(60)
        }
    }

    override func setupViewProperties() {
        super.setupViewProperties()
        view.backgroundColor = Color.background(variant: .regular).uiColor()
        itemsWrapperView.backgroundColor = Color.background(variant: .light).uiColor()
        itemsWrapperView.layer.cornerRadius = 30
        itemsStackView.distribution = .fillEqually
    }

    override func bindView() {
        super.bindView()
        itemTapSubject
            .subscribe(onNext: { [weak self] in self?.viewModel.selectIndex($0) })
            .disposed(by: disposeBag)
    }

    override func bindViewModel() {
        super.bindViewModel()

        viewModel.viewControllers
            .drive(onNext: { [weak self] in self?.update(viewControllers: $0) })
            .disposed(by: disposeBag)

        viewModel.selectedIndex
            .drive(onNext: { [weak self] in self?.update(selectedIndex: $0) })
            .disposed(by: disposeBag)

        viewModel.selectedViewController
            .drive(onNext: { [weak self] in self?.update(selectedViewController: $0) })
            .disposed(by: disposeBag)
    }

}

private extension TabNavigationViewController {
    func update(viewControllers: [TabNavigationAdaptable]) {
        items = viewControllers.map { $0.tabNavigationItem }
    }

    func update(selectedIndex: Int?) {
        items.enumerated().forEach { $0.element.isSelected = $0.offset == selectedIndex }
    }

    func update(selectedViewController: TabNavigationAdaptable?) {
        if let viewController = selectedViewController {
            mainNavigationController.setViewControllers([viewController], animated: false)
        } else {
            mainNavigationController.setViewControllers([], animated: false)
        }
    }
}

private extension TabNavigationViewController {
    func update(currentItems: [TabNavigationItem], previousItems: [TabNavigationItem]) {
        itemTapDisposeBag = DisposeBag()

        previousItems.forEach { $0.removeFromSuperview() }
        currentItems.forEach {
            itemsStackView.addArrangedSubview($0)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 30
        }

        let itemTapEvents = items.enumerated().map { index, item in
            (item as UIView).rx.tapGesture().when(.recognized).map { _ in index }
        }

        Observable.merge(itemTapEvents)
            .bind(to: itemTapSubject)
            .disposed(by: itemTapDisposeBag)
    }
}

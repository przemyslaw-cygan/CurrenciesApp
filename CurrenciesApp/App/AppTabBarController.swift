//
//  AppTabBarController.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 03/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture

class AppTabBarController: UIViewController {

    var items: [Item] {
        get { (try? itemsSubject.value()) ?? [] }
        set { itemsSubject.onNext(newValue) }
    }

    var selectedItem: Item? {
        didSet { update(current: selectedItem, previous: oldValue) }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    private let mainView = UIView()
    private let tabBar = UIView()
    private let tabBarWrapper = UIView()
    private let tabBarStack = UIStackView()

    private let disposeBag = DisposeBag()
    private var itemsSubject = BehaviorSubject<[Item]>(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindView()
    }

}

extension AppTabBarController {
    typealias ItemView = UIButton
    typealias ItemViewController = UIViewController

    class Item {
        let view: ItemView
        let viewController: ItemViewController

        init(with view: ItemView, for viewController: ItemViewController) {
            self.view = view
            self.viewController = viewController
        }
    }
}

extension AppTabBarController: UIViewBuilder, UIViewBinder {
    func setupViewHierarchy() {
        view.addSubview(mainView)
        view.addSubview(tabBar)
        tabBar.addSubview(tabBarWrapper)
        tabBarWrapper.addSubview(tabBarStack)
    }

    func setupViewAutolayout() {
        mainView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tabBar.snp.top)
        }

        tabBar.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }

        tabBarWrapper.snp.makeConstraints {
            $0.top.bottom.equalTo(tabBar.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(tabBar.safeAreaLayoutGuide).inset(10)
        }

        tabBarStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(60)
        }
    }

    func setupViewProperties() {
        view.backgroundColor = Color.background(variant: .regular).uiColor()
        tabBarWrapper.backgroundColor = Color.background(variant: .light).uiColor()
        tabBarWrapper.layer.cornerRadius = 30
        tabBarStack.distribution = .fillEqually
    }

    func bindView() {
        itemsSubject
            .subscribe(onNext: { [weak self] in self?.reload(items: $0) })
            .disposed(by: disposeBag)

        itemTapObservable
            .subscribe(onNext: { [weak self] in self?.selectedItem = $0 })
            .disposed(by: disposeBag)
    }
}

private extension AppTabBarController {
    var itemTapObservable: Observable<Item> {
        itemsSubject
            .map { $0.map { item in
                item.view.rx.tapGesture()
                    .when(.recognized)
                    .compactMap { [weak item] _ in item }
            } }
            .flatMap { Observable.merge($0) }
    }

    func deselect(itemView: ItemView) {
        itemView.isSelected = false
    }

    func select(itemView: ItemView) {
        itemView.isSelected = true
    }

    func deselect(itemViewController: ItemViewController) {
        itemViewController.view.removeFromSuperview()
        itemViewController.removeFromParent()
    }

    func select(itemViewController: ItemViewController) {
        addChild(itemViewController)
        mainView.addSubview(itemViewController.view)
        itemViewController.view.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func reload(items: [Item]) {
        tabBarStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        items.forEach {
            tabBarStack.addArrangedSubview($0.view)
            $0.view.clipsToBounds = true
            $0.view.layer.cornerRadius = 30
        }
        selectedItem = items.first
    }

    func update(current: Item?, previous: Item?) {
        if current?.view != previous?.view {
            if let previousItemView = previous?.view {
                deselect(itemView: previousItemView)
            }
            if let currentItemView = selectedItem?.view {
                select(itemView: currentItemView)
            }
        }

        if current?.viewController != previous?.viewController {
            if let previousItemViewController = previous?.viewController {
                deselect(itemViewController: previousItemViewController)
            }
            if let currentItemViewController = selectedItem?.viewController {
                select(itemViewController: currentItemViewController)
            }
        }
    }
}

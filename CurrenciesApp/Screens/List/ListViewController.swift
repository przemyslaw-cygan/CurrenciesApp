//
//  ListViewController.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 11/08/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class ListViewController: BaseViewController<ListViewModel> {

    private let tableView = UITableView()

    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        view.addSubview(tableView)
    }

    override func setupViewAutolayout() {
        super.setupViewAutolayout()
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }

    override func setupViewProperties() {
        super.setupViewProperties()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(ListItemTableViewCell.self, forCellReuseIdentifier: "ItemCell")
    }

    override func bindView() {
        super.bindView()
    }

    override func bindViewModel() {
        super.bindViewModel()
        viewModel.sections
            .drive(tableView.rx.items(dataSource: Self.dataSource()))
            .disposed(by: disposeBag)
    }

}

extension ListViewController {
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource<ListSection> {
        return .init(
            configureCell: { dataSource, table, indexPath, _ in
                switch dataSource[indexPath] {
                case .currencyInfo(let currency):
                    let cell: ListItemTableViewCell = table.dequeueReusableCell(
                        withIdentifier: "ItemCell",
                        for: indexPath
                    )
                    cell.configure(with: currency)
                    return cell
                }
            }
        )
    }
}

extension ListViewController: TabNavigationAdaptable {
    var tabNavigationItem: TabNavigationItem {
        let item = UIButton()
        item.setImage(UIImage(systemName: "house"), for: .normal)
        item.setBackgroundColor(color: Color.text(variant: .regular).uiColor(with: 0.1), forState: .selected)
        return item
    }
}

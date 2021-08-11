//
//  ListItemTableViewCell.swift
//  CurrenciesApp
//
//  Created by Przemysław Cygan on 11/08/2021.
//

import UIKit
import SnapKit

class ListItemTableViewCell: UITableViewCell {

    private let mainWrapperView = UIView()
    private let mainStackView = UIStackView()
    private let infoImageView = UIImageView()
    private let infoStackView = UIStackView()
    private let infoTitleLabel = UILabel()
    private let infoSubtitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarchy()
        setupViewAutolayout()
        setupViewProperties()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ListItemTableViewCell: UIViewBuilder {
    func setupViewHierarchy() {
        contentView.addSubview(mainWrapperView)
        mainWrapperView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(infoImageView)
        mainStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(infoTitleLabel)
        infoStackView.addArrangedSubview(infoSubtitleLabel)
    }

    func setupViewAutolayout() {
        mainWrapperView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }

        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        infoImageView.snp.makeConstraints {
            $0.width.height.equalTo(60)
        }
    }

    func setupViewProperties() {
        backgroundColor = .clear
        selectionStyle = .none

        mainWrapperView.backgroundColor = Color.background(variant: .light).uiColor()
        mainWrapperView.layer.cornerRadius = 30

        mainStackView.alignment = .center
        mainStackView.spacing = 10

        infoImageView.backgroundColor = Color.text(variant: .regular).uiColor()
        infoImageView.layer.cornerRadius = 30

        infoStackView.axis = .vertical
        infoStackView.spacing = 5

        infoTitleLabel.font = Font.primary.uiFont(with: 16)
        infoTitleLabel.textColor = Color.text(variant: .light).uiColor()

        infoSubtitleLabel.font = Font.primary.uiFont(with: 10)
        infoSubtitleLabel.textColor = Color.text(variant: .dark).uiColor()
    }
}

extension ListItemTableViewCell {
    func configure(with currency: Currency) {
        infoTitleLabel.text = currency.symbol
        infoSubtitleLabel.text = currency.name
    }
}

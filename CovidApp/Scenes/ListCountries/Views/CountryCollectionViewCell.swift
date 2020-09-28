//
//  CountryCollectionViewCell.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

protocol CountryCellView { 
    func configure(with country: Country) 
}

class CountryCollectionViewCell: UICollectionViewCell, CountryCellView {
    
    private let confirmedIcon = "confirmed"
    private let recoveredIcon = "recovered"
    private let diedIcon = "died"
    
    private let countryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var confirmedStatView: StatView = {
        let view = StatView(iconName: confirmedIcon)
        return view
    }()
    
    private lazy var recoveredStatView: StatView = {
        let view = StatView(iconName: recoveredIcon)
        return view
    }()
    
    private lazy var deathsStatView: StatView = {
        let view = StatView(iconName: diedIcon)
        return view
    }()
    
    private lazy var statStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.addArrangedSubview(confirmedStatView)
        stackView.addArrangedSubview(recoveredStatView)
        stackView.addArrangedSubview(deathsStatView)
        return stackView
    }()
    
    var country: Country? {
        didSet {
            countryNameLabel.text = country?.name
            confirmedStatView.set(quantity: country?.totalConfirmed)
            recoveredStatView.set(quantity: country?.totalRecovered)
            deathsStatView.set(quantity: country?.totalDeaths)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        configureCountryLabel(anchorView: self)
        configurestatStackView(topAnchorView: countryNameLabel, remainingAnchorsView: self)
    }
    
    private func configureCountryLabel(anchorView: UIView) {
        addSubview(countryNameLabel)
        countryNameLabel.top(toView: anchorView, constant: 5)
        countryNameLabel.left(toView: anchorView)
        countryNameLabel.right(toView: anchorView)
    }
    
    private func configurestatStackView(topAnchorView: UIView, remainingAnchorsView: UIView) {
        addSubview(statStackView)
        statStackView.relativeTop(toView: topAnchorView, constant: 5)
        statStackView.left(toView: remainingAnchorsView)
        statStackView.right(toView: remainingAnchorsView)
        statStackView.bottom(toView: remainingAnchorsView, constant: 5)
    }
    
    func configure(with country: Country) {
        self.country = country
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

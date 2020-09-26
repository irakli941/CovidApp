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
    
    private let countryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let confirmedStatView: StatView = {
        let view = StatView(iconName: "confirmed")
        return view
    }()
    
    private let recoveredStatView: StatView = {
        let view = StatView(iconName: "recovered")
        return view
    }()
    
    private let deathsStatView: StatView = {
        let view = StatView(iconName: "died")
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
        countryNameLabel.top(toView: anchorView)
        countryNameLabel.left(toView: anchorView)
        countryNameLabel.right(toView: anchorView)
    }
    
    private func configurestatStackView(topAnchorView: UIView, remainingAnchorsView: UIView) {
        addSubview(statStackView)
        statStackView.relativeTop(toView: topAnchorView, constant: 10)
        statStackView.left(toView: remainingAnchorsView)
        statStackView.right(toView: remainingAnchorsView)
        statStackView.bottom(toView: remainingAnchorsView)
    }
    
    func configure(with country: Country) {
        self.country = country
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CountryDetailCellView.swift
//  CovidApp
//
//  Created by Irakli on 9/27/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

class CountryDetailCellView: UICollectionViewCell {
    private let statLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        configureStatLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStatLabel() {
        addSubview(statLabel)
        statLabel.top(toView: self)
        statLabel.left(toView: self)
        statLabel.right(toView: self)
        statLabel.bottom(toView: self)
    }
    
    func configure(with viewModel: CountryDetailCellViewModel) {
        statLabel.text = "\(viewModel.stat): \(viewModel.quantity)"
    }
}

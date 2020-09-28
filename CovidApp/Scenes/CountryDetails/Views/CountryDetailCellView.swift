//
//  CountryDetailCollectionCellView.swift
//  CovidApp
//
//  Created by Irakli on 9/27/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

protocol CountryDetailCellView {
    func configure(with viewModel: CountryDetailCellViewModel)
}

class CountryDetailCollectionCellView: UICollectionViewCell, CountryDetailCellView {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "stat")?.withRenderingMode(.alwaysTemplate))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemBlue
        imageView.width(equalTo: 32)
        return imageView
    }()
    
    private let statLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        configureIconImageView(anchorView: self)
        configureStatLabel(leftAnchorView: iconImageView,
                           remainingAnchorViews: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStatLabel(leftAnchorView: UIView,
                                    remainingAnchorViews: UIView) {
        addSubview(statLabel)
        statLabel.relativeLeft(toView: leftAnchorView, constant: 10)
        statLabel.top(toView: remainingAnchorViews)
        statLabel.right(toView: remainingAnchorViews)
        statLabel.bottom(toView: remainingAnchorViews)
    }
    
    private func configureIconImageView(anchorView: UIView) {
        addSubview(iconImageView)
        iconImageView.left(toView: anchorView)
        iconImageView.top(toView: anchorView, constant: 0)
        iconImageView.bottom(toView: anchorView, constant: 5)
    }
    
    func configure(with viewModel: CountryDetailCellViewModel) {
        statLabel.text = "\(viewModel.stat): \(viewModel.quantity)"
    }
}

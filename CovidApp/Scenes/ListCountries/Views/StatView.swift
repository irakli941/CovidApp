//
//  StatView.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

class StatView: UIView {
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.width(equalTo: 32)
        return imageView
    }()
    
    private var quantity: Int? {
        didSet {
            quantityLabel.text = String(formatNumber(quantity ?? 0))
        }
    }
    
    init(iconName: String) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureImageView(iconName: iconName, anchorView: self)
        configureTitleLabel(leftAnchorView: iconImageView, remainingAnchorsView: self)
    }
    
    private func configureImageView(iconName: String, anchorView: UIView) {
        addSubview(iconImageView)
        let image = UIImage(named: iconName)
        iconImageView.image = image
        iconImageView.left(toView: anchorView)
        iconImageView.top(toView: anchorView)
        iconImageView.bottom(toView: anchorView)
    }
    
    private func configureTitleLabel(leftAnchorView: UIView, remainingAnchorsView: UIView) {
        addSubview(quantityLabel)
        quantityLabel.relativeLeft(toView: leftAnchorView, constant: 10)
        quantityLabel.top(toView: remainingAnchorsView)
        quantityLabel.bottom(toView: remainingAnchorsView)
        quantityLabel.right(toView: remainingAnchorsView)
    }
    
    func set(quantity: Int?) {
        self.quantity = quantity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

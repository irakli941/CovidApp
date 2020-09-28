//
//  CountryDetailsViewController.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

protocol CountryDetailsViewDelegate: class {
    func subscribeClicked(for country: Country)
}

class CountryDetailsViewController: UIViewController {
    // MARK: Properties
    var configurator: CountryDetailsConfigurator!
    var presenter: CountryDetailsPresenter!
    weak var delegate: CountryDetailsViewDelegate?
    //FIXME move consts to seperate model file
    private let detailCellId = "countryDetailCellId"
    private let subscribedIcon = "subscribed"
    private let unsubscribedIcon = "unsubscribed"
    
    private lazy var countryDetailsCollectionView: UICollectionView = {
        var config = UICollectionLayoutListConfiguration(appearance:.insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(CountryDetailCollectionCellView.self,
                                forCellWithReuseIdentifier: detailCellId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(for: self)
        configureBackgroundColor()
        configureCountryListCollectionView(anchorView: self.view)
        presenter.viewDidLoad()
    }
    
    @objc private func subscribeButtonClicked() {
        delegate?.subscribeClicked(for: presenter.parameters.country)
        presenter.subscribeClicked()
    }
    
    private func configureCountryListCollectionView(anchorView: UIView) {
        view.addSubview(countryDetailsCollectionView)
        countryDetailsCollectionView.top(toView: anchorView)
        countryDetailsCollectionView.bottomAnchor.constraint(equalTo: anchorView.bottomAnchor).isActive = true
        countryDetailsCollectionView.left(toView: anchorView)
        countryDetailsCollectionView.right(toView: anchorView)
    }
    
    //FIXME make reusabable and more generic
    private func configureBackgroundColor() {
        
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            view.backgroundColor = .white
        case .dark:
            view.backgroundColor = UIColor.black
        @unknown default:
            view.backgroundColor = UIColor.gray
        }
    }
}

// MARK: CountryDetailsView

extension CountryDetailsViewController: CountryDetailsView {
    func refreshDetailsView() {
        countryDetailsCollectionView.reloadData()
        view.layoutIfNeeded()
    }
    
    func configureFavouritesButton(isSubscribed: Bool) {
        let image = UIImage(named: isSubscribed ? subscribedIcon : unsubscribedIcon)
        let barItem = UIBarButtonItem(image: image,
                                      style: .plain,
                                      target: self,
                                      action: #selector(subscribeButtonClicked))
        self.navigationItem.rightBarButtonItem = barItem
        view.layoutIfNeeded()
    }
}

// MARK: UICollectionViewDataSource

extension CountryDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfStats
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId,
                                                      for: indexPath) as! CountryDetailCollectionCellView
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
}

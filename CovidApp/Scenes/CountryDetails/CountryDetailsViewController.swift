//
//  CountryDetailsViewController.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    var configurator: CountryDetailsConfigurator!
    var presenter: CountryDetailsPresenter!
    
    private let detailCellId = "countryDetailCellId"
    private lazy var countryListCollectionView: UICollectionView = {
        var config = UICollectionLayoutListConfiguration(appearance:.insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(CountryDetailCellView.self, forCellWithReuseIdentifier: detailCellId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(for: self)
        view.backgroundColor = UIColor.white
        configureCountryListCollectionView(anchorView: self.view)
        presenter.viewDidLoad()
    }
    
    private func configureCountryListCollectionView(anchorView: UIView) {
        view.addSubview(countryListCollectionView)
        countryListCollectionView.top(toView: anchorView)
        countryListCollectionView.bottom(toView: anchorView)
        countryListCollectionView.left(toView: anchorView)
        countryListCollectionView.right(toView: anchorView)
    }
}

extension CountryDetailsViewController: CountryDetailsView {
    func refreshDetailsView() {
        countryListCollectionView.reloadData()
        view.layoutIfNeeded()
    }
}

// MARK: UICollectionViewDataSource

extension CountryDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfStats
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! CountryDetailCellView
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
}

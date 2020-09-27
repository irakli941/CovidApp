//
//  ListContriesViewController.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

class ListCountriesViewController: UIViewController {
    
    var configurator = ListCountriesConfigurator()
    var presenter: ListCountriesPresenter!
    private let countryCellId = "CountryViewCell"
    
    private lazy var countryListCollectionView: UICollectionView = {
        var config = UICollectionLayoutListConfiguration(appearance:.insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: countryCellId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(for: self)
        configureCollectionView(anchorView: view)
        presenter.viewDidLoad()
    }
    
    private func configureCollectionView(anchorView: UIView) {
        view.addSubview(countryListCollectionView)
        countryListCollectionView.left(toView: anchorView)
        countryListCollectionView.top(toView: anchorView)
        countryListCollectionView.bottom(toView: anchorView)
        countryListCollectionView.right(toView: anchorView)
    }
}

extension ListCountriesViewController: ListCountriesView {
    func refreshCountriesView() {
        countryListCollectionView.reloadData()
        view.layoutIfNeeded()
    }
}

// MARK: UICollectionViewDataSource

extension ListCountriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCountries
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: countryCellId, for: indexPath) as! CountryCollectionViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension ListCountriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

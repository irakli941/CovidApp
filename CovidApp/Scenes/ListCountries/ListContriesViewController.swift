//
//  ListContriesViewController.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

protocol ListCountriesViewDelegate {
    func webNavigationItemClicked()
}

class ListCountriesViewController: UIViewController {
    // MARK: Properties
    var configurator = ListCountriesConfigurator()
    var presenter: ListCountriesPresenter!
    var delegegate: ListCountriesViewDelegate?
    let reachability = try! Reachability()
    //FIXME move consts to seperate model file
    private let countryCellId = "CountryViewCell"
    private let homePageIconName = "homepage"
    private let sceneTitle = "Covid-19 Feed"
    
    private lazy var countryListCollectionView: UICollectionView = {
        var config = UICollectionLayoutListConfiguration(appearance:.insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CountryCollectionViewCell.self,
                                forCellWithReuseIdentifier: countryCellId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(for: self)
        configureCollectionView(anchorView: view)
        configureNetworkAlerts()
        configureNavigationBar(title: sceneTitle, iconName: homePageIconName)
        configureBackgroundColor()
        presenter.viewDidLoad()
    }
    
    private func configureCollectionView(anchorView: UIView) {
        view.addSubview(countryListCollectionView)
        countryListCollectionView.left(toView: anchorView)
        countryListCollectionView.top(toView: anchorView)
        countryListCollectionView.bottomAnchor.constraint(equalTo: anchorView.bottomAnchor).isActive = true
        countryListCollectionView.right(toView: anchorView)
    }
    
    private func configureNavigationBar(title: String, iconName: String) {
        
        let homepageButton = UIButton(type: .system)
        homepageButton.setImage(UIImage(named: homePageIconName), for: .normal)
        homepageButton.addTarget(self,
                                 action: #selector(webNavigationItemClicked),
                                 for: UIControl.Event.touchUpInside)
        homepageButton.width(equalTo: 32)
        homepageButton.height(equalTo: 32)
        let menuBarItem = UIBarButtonItem(customView: homepageButton)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = menuBarItem
        navigationController?.navigationBar.topItem?.title = title
        view.layoutIfNeeded()
    }
    

    @objc func webNavigationItemClicked() {
        delegegate?.webNavigationItemClicked()
    }
}

extension ListCountriesViewController: ListCountriesView {
    func showError(with title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }

    func refreshCountriesView() {
        countryListCollectionView.reloadData()
        view.layoutIfNeeded()
    }
}

// MARK: UICollectionViewDataSource

extension ListCountriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCountries
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: countryCellId,
                                                      for: indexPath) as! CountryCollectionViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension ListCountriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

extension ListCountriesViewController: CountryDetailsViewDelegate {
    func subscribeClicked(for country: Country) {
        presenter.subscribeClicked(for: country)
    }
}

// MARK: Dark Mode

extension ListCountriesViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        configureBackgroundColor()
    }
    //FIXME make reusabable and more generic. extension?
    private func configureBackgroundColor() {
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            view.backgroundColor = UIColor.white
        case .dark:
            view.backgroundColor = UIColor.black
        @unknown default:
            view.backgroundColor = UIColor.white
        }
    }
}

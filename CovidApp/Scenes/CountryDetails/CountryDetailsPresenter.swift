//
//  CountryDetailsPresenter.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

protocol CountryDetailsView: class {
    func refreshDetailsView()
    func configureFavouritesButton(isSubscribed: Bool)
}

protocol CountryDetailsPresenter {
    var parameters: CountryDetailParameters { get }
    func viewDidLoad()
    var numberOfStats: Int { get }
    func configure(cell: CountryDetailCellView,
                   forRow row: Int)
    func subscribeClicked()
}

class CountryDetailsPresenterImpl: CountryDetailsPresenter {
    
    var parameters: CountryDetailParameters
    private let manageSubscriptionUsecase: ManageCountrySubscriptionsUsecase
    private weak var view: CountryDetailsView?
    var numberOfStats: Int { return stats.count }
    private var isSubscribed: Bool = false {
        didSet {
            view?.configureFavouritesButton(isSubscribed: isSubscribed)
        }
    }
    private var stats:[(String, String)] = [] { didSet { view?.refreshDetailsView() } }
    
    init(manageSubscriptionUsecase: ManageCountrySubscriptionsUsecase,
         parameters: CountryDetailParameters,
         view: CountryDetailsView) {
        self.manageSubscriptionUsecase = manageSubscriptionUsecase
        self.parameters = parameters
        self.view = view
    }
    
    func viewDidLoad() {
        updateStats(with: parameters.country)
        configureSubscriptionStatus(with: parameters.isSubscribed)
    }
    
    private func updateStats(with country: Country) {
        self.stats = country.displayableProperties()
    }
    
    private func configureSubscriptionStatus(with flag: Bool) {
        isSubscribed = flag
    }
    
    func configure(cell: CountryDetailCellView,
                   forRow row: Int) {
        let stat = stats[row]
        let viewModel = CountryDetailCellViewModel(stat: stat.0,
                                                   quantity: stat.1)
        cell.configure(with: viewModel)
    }
    
    func subscribeClicked() {
        self.isSubscribed = !self.isSubscribed
    }
}



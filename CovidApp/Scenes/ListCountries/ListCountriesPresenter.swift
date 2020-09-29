//
//  ListCountriesPresenter.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

protocol ListCountriesView: class {
    func refreshCountriesView()
    func open(url: URL)
    func showError(with title: String, message: String)
}

protocol ListCountriesPresenter {
    var numberOfCountries: Int { get }
    var router: ListCountriesRouter { get }
    func viewDidLoad()
    func configure(cell: CountryCellView, forRow row: Int)
    func didSelect(row: Int)
    func subscribeClicked(for country: Country)
}

class ListCountriesPresenterImpl: ListCountriesPresenter {
    // MARK: Properties
    private weak var view: ListCountriesView?
    private let displayCountriesListUseCase: DisplayCountriesListUseCase
    private let fetchCountrySubscriptionsUseCase: FetchSubscriptionsUseCase
    private let manageSubscriptionUsecase: ManageCountrySubscriptionsUsecase
    internal let router: ListCountriesRouter 
    private let homePage = "https://covid19api.com/"
    private var countries = [Country]() { didSet { view?.refreshCountriesView() } }
    private var subscribedCountries = Set<SubscriptionCountry>() 
    var numberOfCountries: Int {
        return countries.count
    }
    
    init(view: ListCountriesView,
         displayCountriesListUseCase: DisplayCountriesListUseCase,
         fetchCountrySubscriptionsUseCase: FetchSubscriptionsUseCase,
         manageSubscriptionUsecase: ManageCountrySubscriptionsUsecase,
         router: ListCountriesRouter) {
        self.view = view
        self.displayCountriesListUseCase = displayCountriesListUseCase
        self.fetchCountrySubscriptionsUseCase = fetchCountrySubscriptionsUseCase
        self.manageSubscriptionUsecase = manageSubscriptionUsecase
        self.router = router
    }
    
    func viewDidLoad() {
        fetchCountries()
        fetchCountrySubscriptions()
    }
    
    private func fetchCountries() {
        displayCountriesListUseCase.displayCountries { [weak self] (result) in
            guard let self = self else { return } 
            switch result {
            case let .success(countries):
                self.handleCountriesReceived(countries)
            case let .failure(error):
                self.handleCountriesError(error)
            }
        }
    }
    
    private func fetchCountrySubscriptions() {
        fetchCountrySubscriptionsUseCase.fetchCountrySubscriptions { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case let .success(subscribedCountries):
                print(subscribedCountries)
                self.subscribedCountries = subscribedCountries
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func handleCountriesReceived(_ countries: [Country]) {
        self.countries = countries
    }
    
    private func handleCountriesError(_ error: Error) {
        view?.showError(with: "მონაცემები ვერ ჩაიტვირთა", message: "") //FIXME use localized strings
    }
    
    func configure(cell: CountryCellView, forRow row: Int) {
        let country = countries[row]
        
        cell.configure(with: country)
    }
    
    func didSelect(row: Int) {
        router.presentDetails(for: countries[row], isSubscribed: isSubscribed(to: countries[row]))
    }
    
    func subscribeClicked(for country: Country) {
        let subscribed = self.isSubscribed(to: country)
        if subscribed {
            unsubscribe(from: country)
        } else {
            subscribe(to: country)
        }
    }
    
    private func isSubscribed(to country: Country) -> Bool {
        for child in self.subscribedCountries {
            if child.countryCode == country.code {
                return true
            }
        }
        return false
    }
    
    private func subscribe(to country: Country) {
        guard let countryCode = country.code else { return }
        manageSubscriptionUsecase.subscribe(to: SubscriptionCountry(countryCode: countryCode)) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case let .success(subscriptionCountry):
                self.fetchCountrySubscriptions()
                print("successfully subscribed to \(subscriptionCountry.countryCode)")
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func unsubscribe(from country: Country) {
        guard let countryCode = country.code else { return }
        manageSubscriptionUsecase.unsubscribe(from: SubscriptionCountry(countryCode: countryCode)) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case let .success(subscriptionCountry):
                self.fetchCountrySubscriptions()
                print("successfully unsubscribed from \(subscriptionCountry.countryCode)")
            case let .failure(error):
                print(error)
            }
        }
    }
}

// MARK: ListCountriesViewDelegate

extension ListCountriesPresenterImpl: ListCountriesViewDelegate {
    func webNavigationItemClicked() {
        guard let url = URL(string: homePage) else { return }
        view?.open(url: url)
    }
}

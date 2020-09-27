//
//  ListCountriesPresenter.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

protocol ListCountriesView: class {
    func refreshCountriesView()
    func setNavigationBar(title: String)
}

protocol ListCountriesPresenter {
    var numberOfCountries: Int { get }
    var router: ListCountriesRouter { get }
    func viewDidLoad()
    func configure(cell: CountryCellView, forRow row: Int)
    func didSelect(row: Int)
}

class ListCountriesPresenterImpl: ListCountriesPresenter {
    
    private weak var view: ListCountriesView?
    private let displayCountriesListUseCase: DisplayCountriesListUseCase
    private let fetchCountrySubscriptionsUseCase: FetchSubscriptionsUseCase
    internal let router: ListCountriesRouter //FIXME private
    private let homePage = "https://covid19api.com/"
    private var countries = [Country]() { didSet { view?.refreshCountriesView() } }
    private var subscribedCountries = Set<SubscriptionCountry>() 
    var numberOfCountries: Int {
        return countries.count
    }
    
    init(view: ListCountriesView,
         displayCountriesListUseCase: DisplayCountriesListUseCase,
         fetchCountrySubscriptionsUseCase: FetchSubscriptionsUseCase,
         router: ListCountriesRouter) {
        self.view = view
        self.displayCountriesListUseCase = displayCountriesListUseCase
        self.fetchCountrySubscriptionsUseCase = fetchCountrySubscriptionsUseCase
        self.router = router
    }
    
    func viewDidLoad() {
        setNavigationBar(title: "Covid-19 Statistics")
        displayCountriesListUseCase.displayCountries { (result) in
            switch result {
            case let .success(countries):
                self.handleCountriesReceived(countries)
            case let .failure(error):
                self.handleCountriesError(error)
            }
        }
        
        loadNotifications()
    }
    
    private func loadNotifications() {
        fetchCountrySubscriptionsUseCase.fetchCountrySubscriptions { (result) in
            switch result {
            case let .success(subscribedCountries):
                print(subscribedCountries)
                self.subscribedCountries = subscribedCountries
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func setNavigationBar(title: String) {
        view?.setNavigationBar(title: title)
    }
    
    private func handleCountriesReceived(_ countries: [Country]) {
        self.countries = countries
    }
    
    private func handleCountriesError(_ error: Error) {
        print("მონაცემები ვერ ჩაიტვირთა") // FIXME SHOW ALERT
    }
    
    func configure(cell: CountryCellView, forRow row: Int) {
        let country = countries[row]
        
        cell.configure(with: country)
    }
    
    func didSelect(row: Int) {
        router.presentDetails(for: countries[row], isSubscribed: isSubscribed(to: countries[row]))
    }
    
    private func isSubscribed(to country: Country) -> Bool {
        for child in self.subscribedCountries {
            if child.countryCode == country.code {
                return true
            }
        }
        return false
    }
}

extension ListCountriesPresenterImpl: ListCountriesViewDelegate {
    func webNavigationItemClicked() {
        guard let url = URL(string: homePage) else { return }
        UIApplication.shared.open(url)
    }
}

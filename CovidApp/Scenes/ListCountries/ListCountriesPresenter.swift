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
    internal let router: ListCountriesRouter //FIXME private
    private let homePage = "https://covid19api.com/"
    private var countries = [Country]() { didSet { view?.refreshCountriesView() } }
    
    var numberOfCountries: Int {
        return countries.count
    }
    
    init(view: ListCountriesView,
         displayCountriesListUseCase: DisplayCountriesListUseCase,
         router: ListCountriesRouter) {
        self.view = view
        self.displayCountriesListUseCase = displayCountriesListUseCase
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
        router.presentDetails(for: countries[row])
    }
}

extension ListCountriesPresenterImpl: ListCountriesViewDelegate {
    func webNavigationItemClicked() {
        guard let url = URL(string: homePage) else { return }
        UIApplication.shared.open(url)
    }
}

//
//  ListCountriesRouter.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

protocol ListCountriesRouter: class {
    func presentDetails(for country: Country, isSubscribed: Bool)
}

class ListCountriesRouterImpl: ListCountriesRouter {
    
    private weak var viewController: ListCountriesViewController?
    
    init(viewController: ListCountriesViewController) {
        self.viewController = viewController
    }
    
    func presentDetails(for country: Country, isSubscribed: Bool) {
        let params = CountryDetailParameters(country: country, isSubscribed: isSubscribed)
        let countryDetailsViewController = CountryDetailsViewController()
        let countryDetailsConfigurator = CountryDetailsConfigurator(params: params)
        
        countryDetailsViewController.configurator = countryDetailsConfigurator
        countryDetailsViewController.delegate = viewController
        viewController?.navigationController?.pushViewController(countryDetailsViewController, animated: true)
    }
}

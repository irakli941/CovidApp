//
//  ListCountriesRouter.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

protocol ListCountriesRouter: class {
    func presentDetails(for country: Country)
}

class ListCountriesRouterImpl: ListCountriesRouter {
    
    private weak var viewController: ListCountriesViewController?
    
    init(viewController: ListCountriesViewController) {
        self.viewController = viewController
    }
    
    func presentDetails(for country: Country) {
        let params = CountryDetailParameters(country: country)
        let countryDetailsViewController = CountryDetailsViewController()
        let countryDetailsConfigurator = CountryDetailsConfigurator(params: params)
        
        countryDetailsViewController.configurator = countryDetailsConfigurator
        viewController?.navigationController?.pushViewController(countryDetailsViewController, animated: true)
    }
}

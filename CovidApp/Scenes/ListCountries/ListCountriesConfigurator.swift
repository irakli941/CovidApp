//
//  ListCountriesConfigurator.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation


class ListCountriesConfigurator {
    func configure(for viewController: ListCountriesViewController) {
        let apiClient = ApiClientImplementation()
        let apiCoutriesGateway = ApiCountriesGatewayImpl(apiClient: apiClient)
        let displayCountriesListUseCase = DisplayCountriesListUseCaseImpl(countriesGateway: apiCoutriesGateway)
        let router = ListCountriesRouterImpl(viewController: viewController)
        let presenter = ListCountriesPresenterImpl(view: viewController,
                                                   displayCountriesListUseCase: displayCountriesListUseCase,
                                                   router: router)
        viewController.presenter = presenter
    }
}

//
//  ListCountriesConfigurator.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

struct ListCountriesConfigurator {
    func configure(for viewController: ListCountriesViewController) {
        let apiClient = ApiClientImplementation()
        let apiSummaryGateway = ApiSummaryGatewayImpl(apiClient: apiClient)
        let viewContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let coreDataSummaryGateway = CoreDataSummaryGateway(viewContext: viewContext)
        let summaryGateway = CacheSummaryGateWay(apiSummaryGateway: apiSummaryGateway, localPersistenceSummaryGateway: coreDataSummaryGateway)
        let displayCountriesListUseCase = DisplayCountriesListUseCaseImpl(countriesGateway: summaryGateway)
        let router = ListCountriesRouterImpl(viewController: viewController)
        let presenter = ListCountriesPresenterImpl(view: viewController,
                                                   displayCountriesListUseCase: displayCountriesListUseCase,
                                                   router: router)
        viewController.presenter = presenter
        viewController.delegegate = presenter
    }
}

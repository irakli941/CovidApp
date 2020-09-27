//
//  CountryDetailsConfigurator.swift
//  CovidApp
//
//  Created by Irakli on 9/27/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation
struct CountryDetailsConfigurator {
    
    let params: CountryDetailParameters
    
    init(params: CountryDetailParameters) {
        self.params = params
    }
    
    func configure(for viewController: CountryDetailsViewController) {
        let viewContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let notificationsGateway = CoreDataSubscriptionGateway(viewContext: viewContext)
        let manageSubscriptionUsecase = ManageCountrySubscriptionsUsecaseImpl(notificationsGateway: notificationsGateway)
        
        let presenter = CountryDetailsPresenterImpl(manageSubscriptionUsecase: manageSubscriptionUsecase,
                                                    parameters: params,
                                                    view: viewController)
        viewController.presenter = presenter
    }
}

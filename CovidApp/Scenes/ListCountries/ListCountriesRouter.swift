//
//  ListCountriesRouter.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

protocol ListCountriesRouter: class {
    func presentCountryDetails()
}

class ListCountriesRouterImpl: ListCountriesRouter {
    
    private weak var viewController: ListCountriesViewController?
    
    init(viewController: ListCountriesViewController) {
        self.viewController = viewController
    }
    
    func presentCountryDetails() {
        
    }
}

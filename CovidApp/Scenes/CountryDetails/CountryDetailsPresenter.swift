//
//  CountryDetailsPresenter.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

protocol CountryDetailsView {
    
}

protocol CountryDetailsPresenter {
    func viewDidLoad()
}

class CountryDetailsPresenterImpl: CountryDetailsPresenter {
    let parameters: CountryDetailParameters
    let view: CountryDetailsView
    
    init(parameters: CountryDetailParameters,
         view: CountryDetailsView) {
        self.parameters = parameters
        self.view = view
    }
    
    func viewDidLoad() {
        print(parameters)
    }
}

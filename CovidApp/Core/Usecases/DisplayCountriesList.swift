//
//  DisplayCountriesList.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

typealias DisplayCountriesListCompletionHandler = (_ books: Result<[Country]>) -> Void

protocol DisplayCountriesListUseCase {
    func displayCountries(completion: @escaping DisplayCountriesListCompletionHandler)
}

class DisplayCountriesListUseCaseImpl: DisplayCountriesListUseCase {
    let countriesGateway: CountriesGateway
    
    init(countriesGateway: CountriesGateway) {
        self.countriesGateway = countriesGateway
    }
    
    func displayCountries(completion: @escaping DisplayCountriesListCompletionHandler) {
        self.countriesGateway.fetchSummary { (result) in
            switch result {
            case let .success(response):
                completion(.success(response.Countries))
            case let .failure(error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}

//
//  DisplayCountriesList.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

typealias DisplayCountriesListCompletionHandler = (_ countries: Result<[Country]>) -> Void

protocol DisplayCountriesListUseCase {
    func displayCountries(completion: @escaping DisplayCountriesListCompletionHandler)
}

class DisplayCountriesListUseCaseImpl: DisplayCountriesListUseCase {
    let summaryGateway: SummaryGateway
    
    init(summaryGateway: SummaryGateway) {
        self.summaryGateway = summaryGateway
    }
    
    func displayCountries(completion: @escaping DisplayCountriesListCompletionHandler) {
        self.summaryGateway.fetchSummary { (result) in
            switch result {
            case let .success(response):
                completion(.success(response.countries))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

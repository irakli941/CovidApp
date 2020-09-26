//
//  ListCountriesGateway.swift
//  CovidApp
//
//  Created by Irakli on 9/24/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation


typealias CountriesGatewayCompletionHandler = (_ result: Result<Summary>) -> Void

protocol CountriesGateway {
    func fetchSummary(completion: @escaping CountriesGatewayCompletionHandler)
}

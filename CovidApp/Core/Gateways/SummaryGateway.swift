//
//  ListCountriesGateway.swift
//  CovidApp
//
//  Created by Irakli on 9/24/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation


typealias FetchSummaryCompletionHandler = (_ result: Result<Summary>) -> Void

protocol SummaryGateway {
    func fetchSummary(completion: @escaping FetchSummaryCompletionHandler)
}

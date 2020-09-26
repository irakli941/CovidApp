//
//  ApiCountriesGateway.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

protocol ApiCountriesGateway: CountriesGateway {
    
}


class ApiCountriesGatewayImpl: ApiCountriesGateway {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchSummary(completion: @escaping CountriesGatewayCompletionHandler) {
        let request = SummaryApiRequest()
        apiClient.execute(request: request) { (result : Result<ApiResponse<Summary>>) in
            switch result {
            case let .success(response):
                completion(.success(response.entity))
            case let .failure(error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}

//
//  ApiSummaryGateway.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

protocol ApiSummaryGateway: SummaryGateway {
    
}

class ApiSummaryGatewayImpl: ApiSummaryGateway {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchSummary(completion: @escaping FetchSummaryCompletionHandler) {
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

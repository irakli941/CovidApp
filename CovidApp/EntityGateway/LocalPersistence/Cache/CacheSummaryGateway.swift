//
//  CacheSummaryGateway.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

class CacheSummaryGateWay: SummaryGateway {
    
    let apiSummaryGateway: ApiSummaryGateway
    let localPersistenceSummaryGateway: LocalPersistenceSummaryGateway
    
    init(apiSummaryGateway: ApiSummaryGateway, localPersistenceSummaryGateway: LocalPersistenceSummaryGateway) {
        self.apiSummaryGateway = apiSummaryGateway
        self.localPersistenceSummaryGateway = localPersistenceSummaryGateway
    }
    
    func fetchSummary(completion: @escaping FetchSummaryCompletionHandler) {
        apiSummaryGateway.fetchSummary { (result) in
            self.handleFetchSummaryApiResult(result, completion: completion)
        }
    }
    
    private func handleFetchSummaryApiResult(_ result: Result<Summary>, completion: @escaping (Result<Summary>) -> Void) {
        switch result {
        case let .success(summary):
            localPersistenceSummaryGateway.save(summary: summary)
            completion(result)
        case .failure(_):
            localPersistenceSummaryGateway.fetchSummary(completion: completion)
        }
    }
}

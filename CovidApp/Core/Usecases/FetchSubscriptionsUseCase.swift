//
//  FetchCountrySubscriptionsUseCase.swift
//  CovidApp
//
//  Created by Irakli on 9/27/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

typealias FetchCountrySubscriptionsUseCaseCompletionHandler = (_ subscriptionCountries: Result<Set<SubscriptionCountry>>) -> Void

protocol FetchSubscriptionsUseCase {
    func fetchCountrySubscriptions(completion: @escaping FetchCountrySubscriptionsUseCaseCompletionHandler)
}

struct FetchSubscriptionsUseCaseImpl: FetchSubscriptionsUseCase {
    
    let notificationsGateway: NotificationsGateway
    
    init(notificationsGateway: NotificationsGateway) {
        self.notificationsGateway = notificationsGateway
    }
    
    func fetchCountrySubscriptions(completion: @escaping FetchCountrySubscriptionsUseCaseCompletionHandler) {
        self.notificationsGateway.fetchSubscribedCountries { (result) in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

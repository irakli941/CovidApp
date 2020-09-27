//
//  ManageCountrySubscriptionsUsecase.swift
//  CovidApp
//
//  Created by Irakli on 9/28/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

typealias subscribeUsecaseCompletionHandler = (_ result: Result<SubscriptionCountry>) -> Void
typealias unsubscribeUsecaseCompletionHandler = (_ result: Result<SubscriptionCountry>) -> Void

protocol ManageCountrySubscriptionsUsecase{
    func subscribe(to country: SubscriptionCountry, completion: @escaping subscribeUsecaseCompletionHandler)
    func unsubscribe(from country: SubscriptionCountry, completion: @escaping unsubscribeUsecaseCompletionHandler)
}

struct ManageCountrySubscriptionsUsecaseImpl: ManageCountrySubscriptionsUsecase{
    
    let notificationsGateway: NotificationsGateway
    
    init(notificationsGateway: NotificationsGateway) {
        self.notificationsGateway = notificationsGateway
    }
    
    func subscribe(to country: SubscriptionCountry, completion: @escaping subscribeUsecaseCompletionHandler) {
        self.notificationsGateway.subscribe(to: country) { (response) in
            switch response {
            case let .success(country):
                completion(.success(country))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func unsubscribe(from country: SubscriptionCountry, completion: @escaping unsubscribeUsecaseCompletionHandler) {
        self.notificationsGateway.unsubscribe(from: country) { (response) in
            switch response {
            case let .success(country):
                completion(.success(country))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

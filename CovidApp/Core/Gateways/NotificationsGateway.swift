//
//  NotificationsGateway.swift
//  CovidApp
//
//  Created by Irakli on 9/27/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

typealias FetchSubscribedCountriesCompletionHandler = (_ result: Result<Set<SubscriptionCountry>>) -> Void
typealias subscribeCompletionHandler = (_ result: Result<SubscriptionCountry>) -> Void
typealias unsubscribeCompletionHandler = (_ result: Result<SubscriptionCountry>) -> Void

protocol NotificationsGateway {
    func fetchSubscribedCountries(completion: @escaping FetchSubscribedCountriesCompletionHandler)
    func subscribe(to country: SubscriptionCountry, completion: @escaping subscribeCompletionHandler)
    func unsubscribe(from country: SubscriptionCountry, completion: @escaping unsubscribeCompletionHandler)
}

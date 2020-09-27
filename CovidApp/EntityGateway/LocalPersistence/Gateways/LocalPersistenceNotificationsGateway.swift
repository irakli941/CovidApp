//
//  LocalPersistenceNotificationsGateway.swift
//  CovidApp
//
//  Created by Irakli on 9/27/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation
import CoreData

protocol LocalPersistenceNotificationsGateway: NotificationsGateway {
    
}

class CoreDataSubscriptionGateway: LocalPersistenceNotificationsGateway {
    
    let viewContext: NSManagedObjectContextProtocol
    private var fetchedSubscriptions: SubscriptionsCoreData?
    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }
    
    func subscribe(to country: SubscriptionCountry, completion: @escaping subscribeCompletionHandler) {
        guard let coreDataSubscriptionCountry = viewContext.addEntity(withType: SubscriptionCountryCoreData.self) else {
            completion(.failure(CoreError(message: "Failed adding the Subscription in the data base")))
            return
        }
        
        if fetchedSubscriptions != nil {
            coreDataSubscriptionCountry.configure(with: country)
            fetchedSubscriptions!.addToCountrySubscriptions(coreDataSubscriptionCountry)
            do {
                try viewContext.save()
                completion(.success(coreDataSubscriptionCountry.subscriptionCountry))
            } catch {
                completion(.failure(CoreError(message: "Failed to save Subscription entity in the data base")))
            }
        } else {
            completion(.failure(CoreError(message: "Failed to save Subscription entity in the data base")))
        }
    }
    
    func unsubscribe(from country: SubscriptionCountry,  completion: @escaping unsubscribeCompletionHandler) {
        guard let coreDataSubscriptionCountry = viewContext.addEntity(withType: SubscriptionCountryCoreData.self) else {
            completion(.failure(CoreError(message: "Failed adding the Subscription in the data base")))
            return
        }
        
        if fetchedSubscriptions != nil {
            coreDataSubscriptionCountry.configure(with: country)
            fetchedSubscriptions?.removeFromCountrySubscriptions(coreDataSubscriptionCountry)
            do {
                try viewContext.save()
                completion(.success(coreDataSubscriptionCountry.subscriptionCountry))
            } catch {
                completion(.failure(CoreError(message: "Failed to save Subscription entity in the data base")))
            }
        } else {
            completion(.failure(CoreError(message: "Failed to save Subscription entity in the data base")))
        }
    }
    
    func fetchSubscribedCountries(completion: @escaping FetchSubscribedCountriesCompletionHandler) {
        if let subscriptionsCoreData = try? viewContext.allEntities(withType: SubscriptionsCoreData.self) {
            if subscriptionsCoreData.count == 1 {
                self.fetchedSubscriptions = subscriptionsCoreData.first!
                var result:Set<SubscriptionCountry> = []
                
                if let countrySubscriptions = self.fetchedSubscriptions?.countrySubscriptions {
                    for child in countrySubscriptions {
                        result.update(with: (child as! SubscriptionCountryCoreData).subscriptionCountry)
                    }
                } else {
                    completion(.failure(CoreError(message: "Failed retrieving Subscription from the data base")))
                }
                completion(.success(result))
            } else {
                createInitialSubscriptionsCoreData { (response) in
                    // empty subscription created
                }
            }
        } else {
            completion(.failure(CoreError(message: "Failed retrieving Subscription from the data base")))
        }
    }
    
    private func createInitialSubscriptionsCoreData(completion: @escaping (_ result: Result<SubscriptionsCoreData>) -> Void) {
        guard let coreDataSubscriptions = viewContext.addEntity(withType: SubscriptionsCoreData.self) else {
            completion(.failure(CoreError(message: "Failed adding the Subscription in the data base")))
            return
        }
        do {
            try viewContext.save()
            completion(.success(coreDataSubscriptions))
        } catch {
            completion(.failure(CoreError(message: "Failed to save Subscription entity in the data base")))
        }
    }
}

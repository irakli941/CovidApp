//
//  LocalPersistenceCountriesGateway.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation
import CoreData

protocol LocalPersistenceSummaryGateway: SummaryGateway {
    func save(summary: Summary)
}

class CoreDataCountriesGateway: LocalPersistenceSummaryGateway {
    let viewContext: NSManagedObjectContextProtocol
    
    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }
    
    func save(summary: Summary) {
        
    }
    
    func fetchSummary(completion: @escaping (FetchSummaryCompletionHandler)) {
        if let coreDataSummary = try? viewContext.allEntities(withType: SummaryCoreData.self) {
            let countries = coreDataSummary.first?.mutableArrayValue(forKey: "countries") as! [Country]
            let global = coreDataSummary.first?.value(forKey: "global") as! Global
            let summary = Summary(global: global, countries: countries)
            completion(.success(summary))
        } else {
            completion(.failure(CoreError(message: "Failed retrieving books the data base")))
        }
    }
}

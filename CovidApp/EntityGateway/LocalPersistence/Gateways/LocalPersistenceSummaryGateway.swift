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

class CoreDataSummaryGateway: LocalPersistenceSummaryGateway {
    let viewContext: NSManagedObjectContextProtocol
    
    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }
    
    func save(summary: Summary) {
        guard let coreDataGlobal = viewContext.addEntity(withType: GlobalCoreData.self) else {
            print((CoreError(message: "Failed adding the Global in the data base")))
            return
        }
        
        var coreDataCountries:[CountryCoreData] = []
        for country in summary.countries {
            guard let coreDataCountry = viewContext.addEntity(withType: CountryCoreData.self) else {
                print((CoreError(message: "Failed adding the Country in the data base")))
                return
            }
            coreDataCountry.configure(with: country)
            coreDataCountries.append(coreDataCountry)
        }
        
        guard let coreDataSummary = viewContext.addEntity(withType: SummaryCoreData.self) else {
            print((CoreError(message: "Failed adding the Summary in the data base")))
            return
        }
        
        coreDataGlobal.configure(with: summary.global)
        coreDataSummary.configure(with: coreDataGlobal, countries: coreDataCountries)
        
        do {
            try viewContext.save()
        } catch {
            print((CoreError(message: "Failed to save Summary entity in the data base")))
        }
    }
    
    func fetchSummary(completion: @escaping (FetchSummaryCompletionHandler)) {
        if let coreDataSummary = try? viewContext.allEntities(withType: SummaryCoreData.self) {
            completion(.success(coreDataSummary.first!.summary))
        } else {
            completion(.failure(CoreError(message: "Failed retrieving Summary from the data base")))
        }
    }
}

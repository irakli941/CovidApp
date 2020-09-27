//
//  CoreDataCountry.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation
import CoreData

extension GlobalCoreData {
    var global: Global {
        return Global(totalConfirmed: Int(totalConfirmed),
                      totalRecovered: Int(totalRecovered),
                      totalDeaths: Int(totalDeaths))
    }
    
    func configure(with global: Global) {
        totalConfirmed = Int64(global.totalConfirmed ?? 0)
        totalRecovered = Int64(global.totalRecovered ?? 0)
        totalDeaths = Int64(global.totalDeaths ?? 0)
    }
}

//
//  SummaryCoreData.swift
//  CovidApp
//
//  Created by Irakli on 9/27/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

extension SummaryCoreData {
    var summary: Summary {
        return Summary(global: global!.global,
                       countries: (countries?.array as! [CountryCoreData]).map { $0.country })
    }
    
    func configure(with global: GlobalCoreData, countries: [CountryCoreData]) {
        self.global = global
        self.countries = NSOrderedSet(array: countries)
    }
}

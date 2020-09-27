//
//  CountryCoreData.swift
//  CovidApp
//
//  Created by Irakli on 9/27/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation
import CoreData


extension CountryCoreData {
    var country: Country {
        return Country(name: name,
                       code: code,
                       slug: slug,
                       totalConfirmed: Int(totalConfirmed),
                       newConfirmed: Int(newConfirmed),
                       totalRecovered: Int(newConfirmed),
                       newRecovered: Int(newConfirmed),
                       totalDeaths: Int(newConfirmed),
                       newDeaths: Int(newConfirmed))
    }
    
    func configure(with country: Country) {
        name = country.name
        code = country.code
        slug = country.slug
        totalConfirmed = Int64(country.totalConfirmed ?? 0)
        newConfirmed = Int64(country.newConfirmed ?? 0)
        totalRecovered = Int64(country.totalRecovered ?? 0)
        newRecovered = Int64(country.newRecovered ?? 0)
        totalDeaths = Int64(country.totalDeaths ?? 0)
        newDeaths = Int64(country.newDeaths ?? 0)
    }
}

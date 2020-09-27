//
//  Summary.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

struct Summary: Codable {
    let global: Global
    let countries: [Country]
    
    public static let Mock: Summary = Summary(global: Global.Mock,
                                              countries: [Country.Mock])
}

extension Summary {
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
    }
}

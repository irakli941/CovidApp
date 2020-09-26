//
//  Summary.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

struct Summary: Decodable {
    let global: Global
    let countries: [Country]
}

extension Summary {
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
    }
}

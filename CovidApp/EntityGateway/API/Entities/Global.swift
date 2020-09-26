//
//  Global.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

struct Global: Decodable {
    let totalConfirmed: Int?
    let totalRecovered: Int?
    let totalDeaths: Int?
}

extension Global {
    enum CodingKeys: String, CodingKey {
        case totalConfirmed = "TotalConfirmed"
        case totalRecovered = "TotalRecovered"
        case totalDeaths = "TotalDeaths"
    }
}

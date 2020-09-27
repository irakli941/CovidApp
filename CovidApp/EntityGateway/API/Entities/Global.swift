//
//  Global.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

struct Global: Codable {
    let totalConfirmed: Int?
    let totalRecovered: Int?
    let totalDeaths: Int?
    
    public static let Mock: Global = Global(totalConfirmed: 99999,
                                            totalRecovered: 88888,
                                            totalDeaths: 11111)
}

extension Global {
    enum CodingKeys: String, CodingKey {
        case totalConfirmed = "TotalConfirmed"
        case totalRecovered = "TotalRecovered"
        case totalDeaths = "TotalDeaths"
    }
}

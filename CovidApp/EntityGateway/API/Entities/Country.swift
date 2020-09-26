//
//  Country.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String?
    let code: String?
    let slug: String?
    let totalConfirmed: Int?
    let newConfirmed: Int?
    let totalRecovered: Int?
    let newRecovered: Int?
    let totalDeaths: Int?
    let newDeaths: Int?
    
    public static let Mock: Country = Country(name: "Georgia",
                                              code: "GE",
                                              slug: "georgia",
                                              totalConfirmed: 4000,
                                              newConfirmed: 200,
                                              totalRecovered: 3000,
                                              newRecovered: 55,
                                              totalDeaths: 25,
                                              newDeaths: 5)
}

extension Country {
    enum CodingKeys: String, CodingKey {
        case name = "Country"
        case code = "CountryCode"
        case slug = "Slug"
        case totalConfirmed = "TotalConfirmed"
        case newConfirmed = "NewConfirmed"
        case totalRecovered = "TotalRecovered"
        case newRecovered = "NewRecovered"
        case totalDeaths = "TotalDeaths"
        case newDeaths = "NewDeaths"
    }
}

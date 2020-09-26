//
//  Country.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let Country: String?
    let CountryCode: String?
    let Slug: String?
    let TotalConfirmed: Int?
    let TotalRecovered: Int?
    let TotalDeaths: Int?
}

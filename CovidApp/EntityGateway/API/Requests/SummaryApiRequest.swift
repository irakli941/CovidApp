//
//  ListCountriesApiRequest.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

struct SummaryApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        let url: URL! = URL(string: "https://api.covid19api.com/summary")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMehod.get.rawValue
        return request
    }
}

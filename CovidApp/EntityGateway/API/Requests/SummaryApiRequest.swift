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
        request.setValue("44013289-3cf5-4f99-96f7-f26a1e88923e", forHTTPHeaderField: "X-Access-Token")
        return request
    }
}

//
//  Result.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

struct CoreError: Error {
    var localizedDescription: String {
        return message
    }
    
    var message = ""
}

typealias Result<T> = Swift.Result<T, Error>

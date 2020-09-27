//
//  SubscriptionCountryCoreData.swift
//  CovidApp
//
//  Created by Irakli on 9/27/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation
import CoreData

extension SubscriptionCountryCoreData {
    var subscriptionCountry: SubscriptionCountry {
        return SubscriptionCountry(countryCode: countryCode ?? "")
    }
    
    func configure(with country: SubscriptionCountry) {
        self.countryCode = country.countryCode
    }
}

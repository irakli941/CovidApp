//
//  ListCountriesViewController+Reachability.swift
//  CovidApp
//
//  Created by Irakli on 9/28/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

// MARK: Reachavbility alerts

extension ListCountriesViewController {
    func configureNetworkAlerts() {
        reachability.whenUnreachable = { _ in
            //FIXME use localized strings
            self.presentAlert(withTitle: "ქსელის ხარვეზი", message: "ფაფუ ინტერნეტი")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}

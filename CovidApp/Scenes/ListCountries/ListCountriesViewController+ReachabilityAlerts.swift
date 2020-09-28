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
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            if self.connection == .unavailable {
                presenter.networkReturned()
            }
        case .cellular:
            if self.connection == .unavailable {
                presenter.networkReturned()
            }
        case .unavailable:
            self.presentAlert(withTitle: "ქსელის ხარვეზი", message: "ფაფუ ინტერნეტი")
        case .none:
            break
        }
        self.connection = reachability.connection
    }
}

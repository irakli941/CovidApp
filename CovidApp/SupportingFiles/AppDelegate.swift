//
//  AppDelegate.swift
//  CovidApp
//
//  Created by Irakli on 9/18/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // FIXME move to somewhere logical. Mayebe to First Subscription
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) {(granted, error) in
                print("Permission is granted: \(granted)")
            }
        
        return true
    }
}

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
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) {(granted, error) in
                // Make sure permission to receive push notifications is granted
                print("Permission is granted: \(granted)")
            }
        
        return true
    }
}

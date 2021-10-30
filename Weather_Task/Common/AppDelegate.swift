//
//  AppDelegate.swift
//  Weather_Task
//
//  Created by NowPayMacmini-1 on 10/28/20.
//  Copyright © 2020 NowPayMacmini-1. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: AppCoordinator!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        coordinator = AppCoordinator()
        coordinator.start()
        return true
    }

}


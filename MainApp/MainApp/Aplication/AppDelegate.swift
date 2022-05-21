//
//  AppDelegate.swift
//  application
//
//  Created by HuyQuoc on 26/03/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupLogger()
        return true
    }

    func setupLogger() {
        LogManager.configLog(configuration: LogConfiguration())
    }
    
}


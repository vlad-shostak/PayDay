//
//  AppDelegate.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    // MARK: - Private variables
    
    private(set) var appDelegates: [UIApplicationDelegate] = {
        [
            LaunchAppDelegate()
        ]
    }()
    
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        appDelegates.forEach {
            _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        appDelegates.forEach {
            _ = $0.applicationDidBecomeActive?(application)
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        appDelegates.forEach {
            _ = $0.applicationWillEnterForeground?(application)
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        appDelegates.forEach {
            _ = $0.applicationWillResignActive?(application)
        }
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        for appDelegate in appDelegates {
            if let result = appDelegate.application?(
                application,
                continue: userActivity,
                restorationHandler: restorationHandler
                ), result {
                return true
            }
        }

        return false
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        for appDelegate in appDelegates {
            if let result = appDelegate.application?(
                app,
                open: url,
                options: options
                ), result {
                return true
            }
        }

        return false
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        appDelegates.forEach {
            $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        appDelegates.forEach {
            $0.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        appDelegates.forEach {
            $0.application?(
                application,
                didReceiveRemoteNotification: userInfo,
                fetchCompletionHandler: completionHandler
            )
        }
    }
    
}

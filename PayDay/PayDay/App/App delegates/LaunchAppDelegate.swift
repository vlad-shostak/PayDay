//
//  LaunchAppDelegate.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation
import UIKit

final class LaunchAppDelegate: NSObject {
    
    // MARK: - Public variables
    
    var window: UIWindow?
    
}

// MARK: - UIApplicationDelegate

extension LaunchAppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SignUpAssembly.buildModule()
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

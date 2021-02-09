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
        prepareRootView()
        
        return true
    }
    
}

// MARK: - ApplicationRoutingDelegate

extension LaunchAppDelegate: ApplicationRoutingDelegate {
    
    func setRootViewController(_ viewController: BaseScreen) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
}

// MARK: - Private functions

private extension LaunchAppDelegate {
    
    func prepareRootView() {
        let isLoggedIn = (DI.common.userService.get(for: UserServiceKeys.isLoggedIn) as? Bool) ?? false
        
        let rootViewController = isLoggedIn
            ? BaseScreen()
            : SignInAssembly.buildModule()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        setRootViewController(rootViewController)
    }
    
}

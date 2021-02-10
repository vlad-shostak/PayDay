//
//  UIViewControllerExtensions.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var embedInNavigationController: UINavigationController {
        UINavigationController(rootViewController: self)
    }
    
    /// Returns the topmost UIViewController in the UIViewController's hierarhy.
    var topViewController: UIViewController? {
        if isBeingDismissed, let presentingController = presentingViewController {
            return presentingController
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.topViewController
        } else if let tabBarController = self as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return selectedViewController.topViewController
        } else if let navigationController = self as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return visibleViewController.topViewController
        }
        
        return self
    }
    
}

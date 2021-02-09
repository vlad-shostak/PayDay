//
//  DIProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

protocol DIProtocol {
    
    var userNetworkService: UserNetworkServiceProtocol { get }
    var userService: UserServiceProtocol { get }
    var validationService: ValidationServiceProtocol { get }
    var routingService: RoutingServiceProtocol { get }
    
}

// MARK: - DIProtocol

extension DI: DIProtocol {
    
    static var common: DIProtocol {
        shared()
    }
    
    var userNetworkService: UserNetworkServiceProtocol {
        stored(by: #function) {
            UserNetworkService()
        }
    }
    
    var userService: UserServiceProtocol {
        stored(by: #function) {
            UserService()
        }
    }
    
    var validationService: ValidationServiceProtocol {
        stored(by: #function) {
            ValidationService()
        }
    }
    
    var routingService: RoutingServiceProtocol {
        stored(by: #function) {
            RoutingService(
                delegate: (UIApplication.shared.delegate as? AppDelegate)?
                    .appDelegates.first as? LaunchAppDelegate // temporary workaround
            )
        }
    }
    
}

//
//  DIProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

protocol DIProtocol {
    
    var propertyStorage: PropertyStorageProtocol { get }
    var userService: UserServiceProtocol { get }
    var validationService: ValidationServiceProtocol { get }
    var routingService: RoutingServiceProtocol { get }
    var transactionsStorage: TransactionsStorageProtocol { get }
    
    func userNetworkService(serviceLocator: ServiceLocatorProtocol) -> UserNetworkServiceProtocol
    func transactionService(serviceLocator: ServiceLocatorProtocol) -> TransactionsServiceProtocol
    
}

// MARK: - DIProtocol

extension DI: DIProtocol {
    
    static var common: DIProtocol {
        shared()
    }
    
    var propertyStorage: PropertyStorageProtocol {
        stored(by: #function) {
            PropertyStorage()
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
    
    var transactionsStorage: TransactionsStorageProtocol {
        stored(by: #function) {
            TransactionsStorage()
        }
    }
    
    func userNetworkService(serviceLocator: ServiceLocatorProtocol) -> UserNetworkServiceProtocol {
        stored(by: #function) {
            UserNetworkService(serviceLocator: serviceLocator)
        }
    }
    
    func transactionService(serviceLocator: ServiceLocatorProtocol) -> TransactionsServiceProtocol {
        stored(by: #function) {
            TransactionsService(serviceLocator: serviceLocator)
        }
    }
    
}

//
//  ServiceLocator.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

protocol ServiceLocatorProtocol: class {
    
    func getRouter<T>(_ routerProtocol: T.Type) -> T?
    
}

final class ServiceLocator {
    
    // MARK: - Private variables

    private static var uniqueInstance = ServiceLocator()
    private var serviceCache = [String: Any]()
    
    // MARK: - Public variables

    class var sharedInstance: ServiceLocator {
        uniqueInstance
    }
    
    // MARK: - Initialization

    private init () {
        registerRouters()
    }
    
}

// MARK: - ServiceLocatorProtocol

extension ServiceLocator: ServiceLocatorProtocol {
    
    func getRouter<T>(_ routerProtocol: T.Type) -> T? {
        serviceCache["\(routerProtocol)"] as? T
    }
    
}

// MARK: - Private functions

private extension ServiceLocator {
    
    func registerRouters() {
        serviceCache["\(Router<UserEndPoint>.self)"] = Router<UserEndPoint>()
        serviceCache["\(Router<TransactionsEndpoint>.self)"] = Router<TransactionsEndpoint>()
        serviceCache["\(Router<CustomersEndpoint>.self)"] = Router<CustomersEndpoint>()
    }
    
}

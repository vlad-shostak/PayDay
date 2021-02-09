//
//  DIProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

protocol DIProtocol {
    
    var userNetworkService: UserNetworkServiceProtocol { get }
    var userService: UserServiceProtocol { get }
    
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
    
}

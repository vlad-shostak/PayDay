//
//  UserService.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct UserService {
    
    // MARK: - Private variables

    private let propertyStorage = PropertyStorage()

}

// MARK: - UserServiceProtocol

extension UserService: UserServiceProtocol {
    
    var isLoggedIn: Bool {
        propertyStorage.get(forKey: UserServiceKeys.isLoggedIn) ?? false
    }
    
    var userID: Int? {
        propertyStorage.get(forKey: UserServiceKeys.userId)
    }
    
    func setUserID(_ userID: Int) {
        propertyStorage.set(userID, forKey: UserServiceKeys.userId)
    }
    
    func saveUser(_ user: UserModel) {
        propertyStorage.set(true, forKey: UserServiceKeys.isLoggedIn)
        propertyStorage.set(user.id, forKey: UserServiceKeys.userId)
    }
    
    func removeUser() {
        propertyStorage.set(false, forKey: UserServiceKeys.isLoggedIn)
    }
    
}

// MARK: - Keys

private extension UserService {
    
    enum UserServiceKeys {
        
        static let isLoggedIn = "isLoggedIn"
        static let userId = "userId"
        
    }
    
}

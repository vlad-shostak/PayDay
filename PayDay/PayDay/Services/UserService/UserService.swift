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

    private let storage = UserDefaults.standard

}

// MARK: - UserServiceProtocol

extension UserService: UserServiceProtocol {
    
    func saveUser(_ user: UserModel) {
        storage.set(true, forKey: UserServiceKeys.isLoggedIn)
        storage.set(user.id, forKey: UserServiceKeys.userId)
    }
    
    func set(value: Any, for key: String) {
        storage.set(value, forKey: key)
    }
    
    func get<T>(for key: String) -> T? {
        storage.value(forKey: key) as? T
    }
    
    func removeAll() {
        storage.set(false, forKey: UserServiceKeys.isLoggedIn)
    }
    
}

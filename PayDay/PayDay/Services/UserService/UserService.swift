//
//  UserService.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

final class UserService {
    
    // MARK: - Private variables

    private var shared: UserDefaults
    
    // MARK: - Initialization

    init(userDefaults: UserDefaults) {
        shared = UserDefaults.standard
    }

}

// MARK: - UserServiceProtocol

extension UserService: UserServiceProtocol {
    
    func saveUser(_ user: UserModel) {
        shared.set(true, forKey: UserServiceKeys.isLoggedIn)
        shared.set(user.id, forKey: UserServiceKeys.userId)
    }
    
    func set(value: Any, for key: String) {
        shared.set(value, forKey: key)
    }
    
    func get(for key: String) -> Any? {
        shared.value(forKey: key)
    }
    
    func removeAll() {
        shared.set(false, forKey: UserServiceKeys.isLoggedIn)
    }
    
}

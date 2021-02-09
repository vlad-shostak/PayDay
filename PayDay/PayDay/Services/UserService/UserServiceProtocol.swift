//
//  UserServiceProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

protocol UserServiceProtocol {
    
    func saveUser(_ user: UserModel)
    func set(value: Any, for key: String)
    func get(for key: String) -> Any?
    func removeAll()
    
}

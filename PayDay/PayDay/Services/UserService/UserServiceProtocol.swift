//
//  UserServiceProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

protocol UserServiceProtocol {
    
    var isLoggedIn: Bool { get }
    var userID: Int? { get }
    
    func setUserID(_ userID: Int)
    func saveUser(_ user: UserModel)
    func removeUser()
    
}

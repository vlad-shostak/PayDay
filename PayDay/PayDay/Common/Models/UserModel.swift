//
//  UserModel.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let gender: String
    let email: String
    let password: String
    let dob: String
    let phone: String

    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "First Name"
        case lastName = "Last Name"
        case gender
        case email
        case password
        case dob
        case phone
    }
    
}

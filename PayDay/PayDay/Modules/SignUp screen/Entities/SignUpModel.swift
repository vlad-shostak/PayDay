//
//  SignUpModel.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct SignUpModel: Encodable {
    
    // MARK: - Public variables
    
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var password: String
    var gender: String
    var birthDate: Date
    
    static var empty: Self {
        Self(
            firstName: "",
            lastName: "",
            phoneNumber: "",
            email: "",
            password: "",
            gender: "",
            birthDate: Date()
        )
    }
    
    // MARK: - Private
    
    // MARK: Entities
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "First Name"
        case lastName = "Last Name"
        case phoneNumber = "phone"
        case email
        case password
        case gender
        case birthDate = "dob"
    }
    
}

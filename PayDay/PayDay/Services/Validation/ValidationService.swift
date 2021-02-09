//
//  ValidationService.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//


final class ValidationService: ValidationServiceProtocol {
    
    func isValid(password: String) -> ValidationResult {
        if password.count >= ValidationConstants.minPasswordLength {
            return .success
        } else {
            return .error(
                message: "Password should have more than 5 symbols"
            )
        }
    }
    
}

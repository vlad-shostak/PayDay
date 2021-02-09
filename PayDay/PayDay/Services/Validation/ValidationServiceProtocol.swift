//
//  ValidationServiceProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

enum ValidationResult: Equatable {
    case success
    case error(message: String)
}

protocol ValidationServiceProtocol {
    func isValid(password: String) -> ValidationResult
}

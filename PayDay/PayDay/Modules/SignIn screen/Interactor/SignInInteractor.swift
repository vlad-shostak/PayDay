//
//  SignInInteractor.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct SignInInteractor {
    
    // MARK: - External dependencies
    
    var validationService: ValidationServiceProtocol!
    var userNetworkService: UserNetworkServiceProtocol!
    var userService: UserServiceProtocol!
    
}

// MARK: - SignInInteractorProtocol

extension SignInInteractor: SignInInteractorProtocol {
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<UserModel>) -> Void) {
        let validationResult = validationService.isValid(password: password)
        
        switch validationResult {
        case .success:
            userNetworkService.signIn(
                email: email,
                password: password,
                responseHandler: nil
            ) { (result: Result<UserModel>) in
                DispatchQueue.main.async {
                    if case .success(let userModel) = result {
                        self.userService.saveUser(userModel)
                    }
                }
            }
        case .error(let message):
            completion(.failure(message))
        }
    }
    
}

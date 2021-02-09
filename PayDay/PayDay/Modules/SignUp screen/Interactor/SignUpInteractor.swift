//
//  SignUpInteractor.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct SignUpInteractor {
    
    // MARK: - External dependencies
    
    var userNetworkService: UserNetworkServiceProtocol!
    var userService: UserServiceProtocol!
    
}


// MARK: - SignUpInteractorProtocol

extension SignUpInteractor: SignUpInteractorProtocol {
    
    func register(with model: SignUpModel, completion: @escaping (Result<Int>) -> Void) {
        guard isValid(model: model) else {
            return completion(
                .failure("Please fullfill all the required fields")
            )
        }
        
        userNetworkService.registerUser(
            with: model,
            email: model.email,
            phone: model.phoneNumber,
            responseHandler: nil
        ) { result in
            DispatchQueue.main.async {
                if case .success(let userId) = result {
                    self.userService.set(value: userId, for: UserServiceKeys.userId)
                }
                
                completion(result)
            }
        }
    }
    
}

// MARK: - Private functions

private extension SignUpInteractor {
    
    func isValid(model: SignUpModel) -> Bool {
        !model.firstName.isEmpty &&
            !model.lastName.isEmpty &&
            !model.phoneNumber.isEmpty &&
            !model.email.isEmpty &&
            !model.password.isEmpty
    }
    
}

//
//  SignInInteractorProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

protocol SignInInteractorProtocol {
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<UserModel>) -> Void)
    
}

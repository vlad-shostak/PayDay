//
//  UserService.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

protocol UserNetworkServiceProtocol: AnyObject {
    
    func signIn<T: Decodable>(email: String,
                             password: String,
                             responseHandler: ResponseHandlerProtocol?,
                             completion: @escaping (Result<T>) -> Void)
    
    func signUp<T: Encodable>(with model: T,
                              email: String,
                              phone: String,
                              responseHandler: ResponseHandlerProtocol?,
                              completion: @escaping (Result<Int>) -> Void)
    
}

final class UserNetworkService {
    
    // MARK: - Private variables

    private let serviceLocator: ServiceLocatorProtocol
    
    // MARK: - Initialization

    init(serviceLocator: ServiceLocatorProtocol) {
        self.serviceLocator = serviceLocator
    }
    
}

// MARK: - UserNetworkServiceProtocol

extension UserNetworkService: UserNetworkServiceProtocol {
    
    func signIn<T>(email: String,
                   password: String,
                   responseHandler: ResponseHandlerProtocol?,
                   completion: @escaping (Result<T>) -> Void) where T: Decodable {
        signIn(
            email: email,
            password: password,
            responseHandler: responseHandler ?? ResponseHandler(),
            completion: completion
        )
    }

    func signUp<T>(with model: T,
                   email: String,
                   phone: String,
                   responseHandler: ResponseHandlerProtocol?,
                   completion: @escaping (Result<Int>) -> Void) where T: Encodable {
        signUp(
            with: model,
            email: email,
            phone: phone,
            responseHandler: responseHandler ?? ResponseHandler(),
            completion: completion
        )
    }
    
}

// MARK: - Private functions

private extension UserNetworkService {
    
    func signIn<T>(email: String,
                  password: String,
                  responseHandler: ResponseHandlerProtocol,
                  completion: @escaping (Result<T>) -> Void) where T: Decodable {
        let parameters = ["email": email, "password": password]
        
        serviceLocator.getRouter(Router<UserEndpoint>.self)?.request(.signIn(parameters: parameters)) { (data, response, error) in
            let result = responseHandler.handleResponse(T.self, data, response, error)
            
            completion(result)
        }
    }
    
    func signUp<T>(with model: T,
                   email: String,
                   phone: String,
                   responseHandler: ResponseHandlerProtocol,
                   completion: @escaping (Result<Int>) -> Void) where T: Encodable {
        var isEmailExisting = false
        var isPhoneExisting = false
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        checkEmailExisting(email: email) {
            isEmailExisting = $0
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        checkPhoneExisting(phone: phone) {
            isPhoneExisting = $0
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            if !isEmailExisting, !isPhoneExisting {
                self.signUpUser(
                    with: model,
                    responseHandler: responseHandler,
                    completion: completion
                )
            } else {
                var message = isEmailExisting ? "User with this email already exists. " : ""
                message += isPhoneExisting ? "User with this phone already exists." : ""
                
                completion(.failure(message))
            }
        }
    }

    func signUpUser<T>(with model: T,
                       responseHandler: ResponseHandlerProtocol,
                       completion: @escaping (Result<Int>) -> Void)  where T: Encodable {
        guard let data = try? JSONEncoder().encode(model) else {
            return completion(.failure("Something went wrong."))
        }

        serviceLocator.getRouter(Router<UserEndpoint>.self)?.request(.signUp(data: data)) { (responseData, _, error) in
            if let errorMessage = error?.localizedDescription {
                return completion(.failure(errorMessage))
            }

            guard
                let unwrappedData = responseData,
                let result = try? JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String: AnyObject],
                let userId = result["id"] as? Int
            else {
                return completion(.failure("Something went wrong."))
            }

            completion(.success(userId))
        }
    }

    func checkEmailExisting(email: String, completion: @escaping (_ isExisting: Bool) -> Void) {
        serviceLocator.getRouter(Router<CustomersEndpoint>.self)?.request(.checkEmail(email: email)) { (data, _, _) in
            if let data = data,
               let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [AnyObject],
               !jsonData.isEmpty {
                return completion(true)
            }

            completion(false)
        }
    }

    func checkPhoneExisting(phone: String, completion: @escaping (_ isExisting: Bool) -> Void) {
        serviceLocator.getRouter(Router<CustomersEndpoint>.self)?.request(.checkPhone(phone: phone)) { (data, _, _) in
            if let data = data,
               let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [AnyObject],
               !jsonData.isEmpty {
                return completion(true)
            }

            completion(false)
        }
    }
    
}

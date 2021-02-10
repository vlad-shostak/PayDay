//
//  TransactionsService.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

protocol TransactionsServiceProtocol: AnyObject {
    
    func getAllTransactions<T: Decodable>(accountId: Int,
                                          responseHandler: ResponseHandlerProtocol?,
                                          completion: @escaping (Result<[T]>) -> Void)
    
}

final class TransactionsService {
    
    // MARK: - Private variables

    private let serviceLocator: ServiceLocatorProtocol
    
    // MARK: - Initialization

    init(serviceLocator: ServiceLocatorProtocol? = nil) {
        self.serviceLocator = serviceLocator ?? ServiceLocator.sharedInstance
    }
    
}

// MARK: - TransactionsServiceProtocol

extension TransactionsService: TransactionsServiceProtocol {
    
    func getAllTransactions<T>(accountId: Int,
                               responseHandler: ResponseHandlerProtocol?,
                               completion: @escaping (Result<[T]>) -> Void) where T: Decodable {
        getAllTransactions(
            accountId: accountId,
            responseHandler: responseHandler ?? ResponseHandler(),
            completion: completion
        )
    }
    
}

// MARK: - Private functions

private extension TransactionsService {
    
    func getAllTransactions<T>(accountId: Int,
                               responseHandler: ResponseHandlerProtocol,
                               completion: @escaping (Result<[T]>) -> Void) where T: Decodable {
        serviceLocator.getRouter(
            Router<TransactionsEndpoint>.self
        )?
            .request(
                .getTransactions(accountId: accountId)
            ) { (data, response, error) in
                let result = responseHandler.handleResponse(
                    [T].self,
                    data,
                    response,
                    error
                )
                
                completion(result)
        }
    }
    
}

//
//  ResponseHandler.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

protocol ResponseHandlerProtocol: class {
    
    func handleResponse<T: Decodable>(_ modelClass: T.Type,
                                      _ data: Data?,
                                      _ response: URLResponse?,
                                      _ error: Error?) -> Result<T>
    
}

final class ResponseHandler {
    
    // MARK: - Initialization

    init() {}
    
}

// MARK: - ResponseHandlerProtocol

extension ResponseHandler: ResponseHandlerProtocol {
    
    func handleResponse<T: Decodable>(_ modelClass: T.Type,
                                      _ data: Data?,
                                      _ response: URLResponse?,
                                      _ error: Error?) -> Result<T> {
        if error != nil {
            return .failure("Please check your network connection.")
        }

        if let response = response as? HTTPURLResponse {
            let result = handleNetworkStatus(response)
            
            switch result {
            case .success:
                guard let responseData = data else {
                    return .failure(NetworkResponse.noData.rawValue)
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                    
                    return .success(apiResponse)
                } catch {
                    return .failure(NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                return .failure(networkFailureError)
            }
        }

        return .failure("Unexpected error")
    }
    
}

// MARK: - Private functions

private extension ResponseHandler {
    
    func handleNetworkStatus(_ response: HTTPURLResponse) -> Result<Any> {
        switch response.statusCode {
        case 200...299:
            return .success(Any.self)
        case 401...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}

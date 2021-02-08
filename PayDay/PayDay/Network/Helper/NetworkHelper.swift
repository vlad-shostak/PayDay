//
//  NetworkHelper.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    
    case success
    case authenticationError = "Login or password is incorrect."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    
}

enum Result<Value> {
    
    case success(Value)
    case failure(String)
    
}

enum NetworkEnvironment {
    case production
}

final class NetworkHelper {
    
    // MARK: - Private variables

    private static let uniqueInstance = NetworkHelper()
    private static let environment: NetworkEnvironment = .production

    // MARK: - Public variables
    
    static var environmentBaseURL: String {
        switch NetworkHelper.environment {
        case .production:
            return "http://localhost:3000/"
        }
    }

    class var sharedInstance: NetworkHelper {
        uniqueInstance
    }

    // MARK: - Initialization
    
    private init () {}
    
}

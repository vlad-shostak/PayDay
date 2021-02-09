//
//  AuthenticationEndpoint.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

enum UserEndpoint {
    
    case login(parameters: Parameters)
    case register(data: Data)
    
}

// MARK: - EndpointType

extension UserEndpoint: EndpointType {

    var baseURL: URL {
        guard let url = URL(string: NetworkHelper.environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        
        return url
    }

    var path: String {
        switch self {
        case .login: return "authenticate"
        case .register: return "customers"
        }
    }

    var httpMethod: HTTPMethod {
        .post
    }

    var task: HTTPTask {
        switch self {
        case .login(let parametes):
            return .requestParameters(
                bodyParameters: parametes,
                bodyEncoding: .jsonEncoding,
                urlParameters: nil
            )
        case .register(let data):
            return .requestData(data: data)
        }
    }

    var headers: HTTPHeaders? {
        nil
    }
    
}

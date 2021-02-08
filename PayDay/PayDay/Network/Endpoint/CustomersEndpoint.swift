//
//  CustomersEndpoint.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

enum CustomersEndpoint {

    case checkEmail(email: String)
    case checkPhone(phone: String)
    
}

// MARK: - EndpointType

extension CustomersEndpoint: EndpointType {

    var baseURL: URL {
        guard let url = URL(string: NetworkHelper.environmentBaseURL) else { fatalError("baseURL could not be configured.")
        }
        
        return url
    }

    var path: String {
        "customers"
    }

    var httpMethod: HTTPMethod {
        .get
    }

    var task: HTTPTask {
        switch self {
        case .checkEmail(let email):
            let urlParameters = ["email": email as AnyObject]

            return .requestParameters(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: urlParameters
            )

        case .checkPhone(let phone):
            let urlParameters = ["phone": phone as AnyObject]

            return .requestParameters(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: urlParameters
            )
        }
    }

    var headers: HTTPHeaders? {
        nil
    }
    
}

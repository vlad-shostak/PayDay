//
//  TransactionsEndpoint.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

enum TransactionsEndpoint {
    case getTransactions(accountId: Int)
}

// MARK: - EndpointType

extension TransactionsEndpoint: EndpointType {

    var baseURL: URL {
        guard let url = URL(string: NetworkHelper.environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        
        return url
    }

    var path: String {
        switch self {
        case .getTransactions:
            return "transactions"
        }
    }

    var httpMethod: HTTPMethod {
        .get
    }

    var task: HTTPTask {
        switch self {
        case .getTransactions(let accountId):
            return .requestParameters(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: ["account_id": accountId]
            )
        }
    }

    var headers: HTTPHeaders? {
        nil
    }
    
}

//
//  JSONParameterEncoder.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    
    // MARK: - Public functions
    
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
}

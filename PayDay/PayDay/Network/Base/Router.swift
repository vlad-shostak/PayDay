//
//  Router.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

typealias Completion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol URLSessionProtocol: class {
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
}

protocol NetworkRouterProtocol: class {
    
    associatedtype EndPoint: EndpointType
    
    func request(_ route: EndPoint,
                 urlSession: URLSessionProtocol?,
                 completion: @escaping Completion)
    
    func cancel()
    
}

class Router<EndPoint: EndpointType>: NetworkRouterProtocol {
    
    // MARK: - Private variables
    
    private var task: URLSessionTask?
    
    // MARK: - Public functions

    func request(_ route: EndPoint,
                        urlSession: URLSessionProtocol? = URLSession.shared,
                        completion: @escaping Completion) {
        do {
            let request = try route.buildRequest()
            
            #if DEBUG
            NetworkLogger.log(request: request)
            #endif
            
            task = urlSession?.dataTask(with: request) { data, response, error in
                completion(data, response, error)
            }
        } catch {
            completion(nil, nil, error)
        }
        
        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }
    
}

// MARK: - URLSessionProtocol

extension URLSession: URLSessionProtocol {}

//
//  RoutingService.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

protocol ApplicationRoutingDelegate: AnyObject {
    func setRootViewController(_ viewController: Screen)
}

protocol RoutingServiceProtocol: ApplicationRoutingDelegate {}

final class RoutingService {
    
    // MARK: - Private variables
    
    weak var delegate: ApplicationRoutingDelegate?
    
    // MARK: - Initialization
    
    init(delegate: ApplicationRoutingDelegate?) {
        self.delegate = delegate
    }
    
}

// MARK: - RoutingServiceProtocol

extension RoutingService: RoutingServiceProtocol {
    
    func setRootViewController(_ viewController: Screen) {
        delegate?.setRootViewController(viewController)
    }
    
}

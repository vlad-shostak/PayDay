//
//  TransactionsRouter.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class TransactionsRouter {
    
    // MARK: - Private variables
    
    private weak var view: BaseScreen?
    
    private let routingService: RoutingServiceProtocol
    
    // MARK: - Initialization
    
    init(view: BaseScreen, routingService: RoutingServiceProtocol) {
        self.view = view
        self.routingService = routingService
    }
    
}

// MARK: - TransactionsRouterProtocol

extension TransactionsRouter: TransactionsRouterProtocol {
    
    func routeToSignIn() {
        routingService.setRootViewController(
            SignInAssembly.buildModule()
        )
    }
    
}

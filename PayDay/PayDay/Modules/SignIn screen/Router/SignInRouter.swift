//
//  SignInRouter.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class SignInRouter {
    
    // MARK: - Private variables
    
    private weak var view: BaseScreen?
    
    private let routingService: RoutingServiceProtocol
    
    // MARK: - Initialization
    
    init(view: BaseScreen, routingService: RoutingServiceProtocol) {
        self.view = view
        self.routingService = routingService
    }
    
}

// MARK: - SignInRouterProtocol

extension SignInRouter: SignInRouterProtocol {
    
    func routeToSignUp() {
        routingService.setRootViewController(
            SignUpAssembly.buildModule().embedInNavigationController
        )
    }
    
    func routeToTransactions() {
        routingService.setRootViewController(
            TransactionsAssembly.buildModule().embedInNavigationController
        )
    }
    
}

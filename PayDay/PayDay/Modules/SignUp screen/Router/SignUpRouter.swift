//
//  SignUpRouter.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

final class SignUpRouter {
    
    // MARK: - Private variables
    
    private weak var view: BaseScreen?
    
    // MARK: - Initialization
    
    init(view: BaseScreen) {
        self.view = view
    }
    
}

// MARK: - SignUpRouterProtocol

extension SignUpRouter: SignUpRouterProtocol {
    
    func routeToSignIn() {
        print("routeToSignIn")
    }
    
    func routeToTransactions() {
        print("routeToTransactions")
    }
    
}

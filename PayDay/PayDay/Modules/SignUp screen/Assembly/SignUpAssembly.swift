//
//  SignUpAssembly.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class SignUpAssembly {
    
    // MARK: - Public functions
    
    static func buildModule() -> BaseScreen {
        let view = SignUpScreen()
        let presenter = SignUpPresenter()
        let interactor = makeInteractor()
        
        let router = SignUpRouter(
            view: view,
            routingService: DI.common.routingService
        )
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.output = presenter
        view.addLifecycleListener(presenter)
        
        return view
    }
    
}

// MARK: - Private functions

private extension SignUpAssembly {
    
    static func makeInteractor() -> SignUpInteractor {
        var interactor = SignUpInteractor()
        interactor.userNetworkService = DI.common.userNetworkService
        interactor.userService = DI.common.userService
        interactor.validationService = DI.common.validationService
        
        return interactor
    }
    
}

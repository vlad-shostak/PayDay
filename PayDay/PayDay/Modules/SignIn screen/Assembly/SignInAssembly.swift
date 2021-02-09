//
//  SignInAssembly.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class SignInAssembly {
    
    // MARK: - Public functions
    
    static func buildModule() -> BaseScreen {
        let view = SignInScreen()
        let presenter = SignInPresenter()
        let interactor = makeInteractor()
        
        let router = SignInRouter(
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

private extension SignInAssembly {
    
    static func makeInteractor() -> SignInInteractor {
        var interactor = SignInInteractor()
        interactor.userNetworkService = DI.common.userNetworkService
        interactor.userService = DI.common.userService
        interactor.validationService = DI.common.validationService
        
        return interactor
    }
    
}

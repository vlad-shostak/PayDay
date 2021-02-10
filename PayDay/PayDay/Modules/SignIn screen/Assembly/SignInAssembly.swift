//
//  SignInAssembly.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class SignInAssembly {
    
    // MARK: - Public functions
    
    static func buildModule() -> Screen {
        let view = SignInScreen()
        
        let router = SignInRouter(
            view: view,
            routingService: DI.common.routingService
        )
        
        let interactor = SignInInteractor(
            validationService: DI.common.validationService,
            userNetworkService: DI.common.userNetworkService,
            userService: DI.common.userService
        )
        
        let presenter = SignInPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.output = presenter
        view.addLifecycleListener(presenter)
        
        return view
    }
    
}

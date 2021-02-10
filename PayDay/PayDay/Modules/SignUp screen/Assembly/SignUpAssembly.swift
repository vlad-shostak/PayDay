//
//  SignUpAssembly.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class SignUpAssembly {
    
    // MARK: - Public functions
    
    static func buildModule() -> Screen {
        let view = SignUpScreen()
        
        let router = SignUpRouter(
            view: view,
            routingService: DI.common.routingService
        )
        
        let interactor = SignUpInteractor(
            userNetworkService: DI.common.userNetworkService,
            userService: DI.common.userService,
            validationService: DI.common.validationService
        )
        
        let presenter = SignUpPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.output = presenter
        view.addLifecycleListener(presenter)
        
        return view
    }
    
}

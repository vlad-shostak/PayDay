//
//  TransactionsAssembly.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class TransactionsAssembly {
    
    // MARK: - Public functions
    
    static func buildModule() -> Screen {
        let view = TransactionsScreen()
        
        let router = TransactionsRouter(
            view: view,
            routingService: DI.common.routingService
        )
        
        let interactor = TransactionsInteractor(
            userService: DI.common.userService,
            transactionsStorage: DI.common.transactionsStorage,
            transactionService: DI.common.transactionService
        )
        
        let presenter = TransactionsPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.output = presenter
        view.addLifecycleListener(presenter)
        
        return view
    }
    
}

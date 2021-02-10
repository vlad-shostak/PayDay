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
        let presenter = TransactionsPresenter()
        let interactor = makeInteractor()
        
        let router = TransactionsRouter(
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

private extension TransactionsAssembly {
    
    static func makeInteractor() -> TransactionsInteractor {
        var interactor = TransactionsInteractor()
        interactor.userService = DI.common.userService
        interactor.transactionsStorage = DI.common.transactionsStorage
        interactor.transactionService = DI.common.transactionService
        
        return interactor
    }
    
}

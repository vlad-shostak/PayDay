//
//  TransactionsPresenter.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class TransactionsPresenter {
    
    // MARK: - Private
    
    // MARK: External dependencies
    
    private unowned let view: TransactionsScreenInput
    private let interactor: TransactionsInteractorProtocol
    private let router: TransactionsRouterProtocol
    
    // MARK: - Initialization
    
    init(view: TransactionsScreenInput,
         interactor: TransactionsInteractorProtocol,
         router: TransactionsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - TransactionsScreenOutput

extension TransactionsPresenter: TransactionsScreenOutput {
    
    func didAskToMakeLogout() {
        interactor.logout()
        router.routeToSignIn()
    }
    
}

// MARK: - LifecycleListener

extension TransactionsPresenter: LifecycleListener {
    
    func viewDidLoad() {
        obtainTransactions()
    }
    
}

// MARK: - Private functions

private extension TransactionsPresenter {
    
    func obtainTransactions() {
        interactor.obtainTransactions { [weak self] result in
            switch result {
            case .success(let transactions):
                self?.view.updateTransactions(transactions)
            case .failure(let message):
                self?.showErrorAlert(with: message)
            }
        }
    }
    
    func showErrorAlert(with message: String) {
        view.showAlert(
            title: "Error",
            message: message,
            actions: [.ok()]
        )
    }
    
}

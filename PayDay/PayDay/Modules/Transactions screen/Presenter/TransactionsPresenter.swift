//
//  TransactionsPresenter.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class TransactionsPresenter {
    
    // MARK: - External dependencies
    
    unowned var view: TransactionsScreenInput!
    var interactor: TransactionsInteractorProtocol!
    var router: TransactionsRouterProtocol!
    
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

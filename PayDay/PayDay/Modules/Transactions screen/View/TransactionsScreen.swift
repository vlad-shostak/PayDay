//
//  TransactionsScreen.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

final class TransactionsScreen: BaseScreen {
    
    // MARK: - External dependencies
    
    var output: TransactionsScreenOutput!
    
    // MARK: - Private
    
    // MARK: UI
    
    private let tableView = TransactionsTableView()
    
    // MARK: - Override functions
    
    override func loadView() {
        super.loadView()
     
        setupNavigationBar()
        setupView()
        setupLayout()
    }
    
}

// MARK: - TransactionsScreenInput

extension TransactionsScreen: TransactionsScreenInput {
    
    func updateTransactions(_ transactions: [DailyTransactionsModel]) {
        tableView.reload(model: transactions)
    }
    
}

// MARK: - Private functions

private extension TransactionsScreen {
    
    func setupNavigationBar() {
        navigationItem.title = "Transactions"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .done
        ) { [weak self] _ in
            self?.output.didAskToMakeLogout()
        }
    }
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func setupLayout() {
        view.addSubview(tableView) {
            $0.pinToSuperview()
        }
    }
    
}


//
//  TransactionsInteractor.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct TransactionsInteractor {
    
    // MARK: - Private
    
    // MARK: External dependencies
    
    private let userService: UserServiceProtocol
    private let transactionsStorage: TransactionsStorageProtocol
    private let transactionService: TransactionsServiceProtocol
    
    // MARK: - Initialization
    
    init(userService: UserServiceProtocol,
         transactionsStorage: TransactionsStorageProtocol,
         transactionService: TransactionsServiceProtocol) {
        self.userService = userService
        self.transactionsStorage = transactionsStorage
        self.transactionService = transactionService
    }
    
}

// MARK: - TransactionsInteractorProtocol

extension TransactionsInteractor: TransactionsInteractorProtocol {
    
    func logout() {
        userService.removeUser()
        transactionsStorage.removeAll()
    }
    
    func obtainTransactions(completion: @escaping (Result<[DailyTransactionsModel]>) -> Void) {
        if let transactions: [TransactionModel] = transactionsStorage.get(request: Constants.transactions), !transactions.isEmpty {
            let group = groupTransactions(
                from: TransactionModels(transactions: transactions)
            )
            
            DispatchQueue.main.async {
                completion(.success(group))
            }
            
            return
        }
        
        guard let userID = userService.userID else {
            return completion(.failure("Something went wrong"))
        }
        
        transactionService.getAllTransactions(
            accountId: userID,
            responseHandler: nil
        ) { (result: Result<TransactionModels>) in
            switch result {
            case .success(let models):
                self.transactionsStorage.put(request: Constants.transactions, with: models)
                
                let group = self.groupTransactions(from: models)
                
                DispatchQueue.main.async {
                    completion(.success(group))
                }
            case .failure(let message):
                DispatchQueue.main.async {
                    completion(.failure(message))
                }
            }
        }
    }
    
}

// MARK: - Private functions

private extension TransactionsInteractor {
    
    func groupTransactions(from model: TransactionModels) -> [DailyTransactionsModel] {
        guard !model.transactions.isEmpty else { return [] }
        
        var group: [DailyTransactionsModel] = []
        
        let groupDictionary = makeGroupDictionary(from: model.transactions)
        
        groupDictionary.forEach { date, transactions in
            guard let date = date else { return }
            
            let model = DailyTransactionsModel(
                date: date,
                transactions: sortTransactions(transactions)
            )
            
            group.append(model)
        }
        
        return sortGroup(group)
    }
    
    func makeGroupDictionary(from model: [TransactionModel]) -> [Date? : [TransactionModel]] {
        Dictionary(grouping: model) {
            DateFormatterHelper.stringToDate(string: $0.date, format: .general).flatMap {
                let calendar = Calendar.current
                
                var date = calendar.dateComponents(
                    [.day, .year, .month, .hour, .minute, .second],
                    from: $0
                )
                
                date.calendar = calendar
                
                return date.date
            }
        }
    }
    
    func sortTransactions(_ transactions: [TransactionModel]) -> [TransactionModel] {
        transactions.sorted { $0.date > $1.date }
    }
    
    func sortGroup(_ group: [DailyTransactionsModel]) -> [DailyTransactionsModel] {
        group.sorted { $0.date > $1.date }
    }
    
}

// MARK: - Constants

private extension TransactionsInteractor {
    
    enum Constants {
        static let transactions = "transactions"
    }
    
}

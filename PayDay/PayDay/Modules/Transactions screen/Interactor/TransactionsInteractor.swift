//
//  TransactionsInteractor.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct TransactionsInteractor {
    
    var userService: UserServiceProtocol!
    var transactionsStorage: TransactionsStorageProtocol!
    var transactionService: TransactionsServiceProtocol!
    
}

// MARK: - TransactionsInteractorProtocol

extension TransactionsInteractor: TransactionsInteractorProtocol {
    
    func logout() {
        userService.removeAll()
        transactionsStorage.removeAll()
    }
    
    func obtainTransactions(completion: @escaping (Result<[DailyTransactionsModel]>) -> Void) {
        if let transactions: [TransactionModel] = transactionsStorage.get(request: Constants.transactions), !transactions.isEmpty {
            let group = groupTransactions(from: transactions)
            
            DispatchQueue.main.async {
                completion(.success(group))
            }
            
            return
        }
        
        guard let userID: Int = userService.get(for: UserServiceKeys.userId) else {
            return completion(.failure("Something went wrong"))
        }
        
        transactionService.getAllTransactions(
            accountId: userID,
            responseHandler: nil
        ) { (result: Result<[TransactionModel]>) in
            switch result {
            case .success(let transactions):
                self.transactionsStorage.put(request: Constants.transactions, with: transactions)
                
                let group = self.groupTransactions(from: transactions)
                
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
    
    func groupTransactions(from model: [TransactionModel]) -> [DailyTransactionsModel] {
        guard !model.isEmpty else { return [] }
        
        var group: [DailyTransactionsModel] = []
        
        let groupDictionary = makeGroupDictionary(from: model)
        
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
            DateFormatterService.stringToDate(string: $0.date, format: .general).flatMap {
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
    
    struct Constants {
        static let transactions = "transactions"
    }
    
}

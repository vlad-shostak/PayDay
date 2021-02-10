//
//  TransactionsInteractorProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

protocol TransactionsInteractorProtocol {
    
    func logout()
    func obtainTransactions(completion: @escaping (Result<[DailyTransactionsModel]>) -> Void)
    
}

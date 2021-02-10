//
//  TransactionsStorage.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

final class TransactionsStorage {
    
    // MARK: - Private functions

    private var storage = [String: AnyHashable]()
    
}

// MARK: - TransactionsStorageProtocol

extension TransactionsStorage: TransactionsStorageProtocol {
    
    func get<T: Hashable>(request: Request) -> T? {
        storage[request] as? T
    }

    @discardableResult func put<T: Hashable>(request: Request, with value: T) -> Bool {
        storage[request] = value
        
        return true
    }

    func removeAll() {
        storage.removeAll()
    }
    
}

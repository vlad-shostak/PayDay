//
//  TransactionsStorageProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

typealias Request = String

protocol TransactionsStorageProtocol: class {
    
    func get<T: Hashable>(request: Request) -> T?
    @discardableResult func put<T: Hashable>(request: Request, with value: T) -> Bool
    func removeAll()
}

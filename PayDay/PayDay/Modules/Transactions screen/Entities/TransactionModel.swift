//
//  TransactionModel.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct TransactionModel: Hashable, Codable {
    
    var id: Int
    var accountId: Int
    var amount: String
    var vendor: String
    var category: String
    var date: String

    private enum CodingKeys: String, CodingKey {
        case id
        case accountId = "account_id"
        case amount
        case vendor
        case category
        case date
    }
    
}

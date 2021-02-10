//
//  DailyTransactionsModel.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct DailyTransactionsModel: Hashable {
    
    var date: Date
    var transactions: [TransactionModel]
    
}

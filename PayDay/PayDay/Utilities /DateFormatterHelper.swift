//
//  DateFormatterHelper.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

enum DateFormat: String {
    
    case general = "yyyy-MM-dd'T'HH:mm:ssZ"
    case transaction = "MMM dd, yyyy"
    case dailyGroupedTransactions = "MMM dd"
    
}

enum DateFormatterHelper {
    
    static func stringToDate(string: String, format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.date(from: string)
    }
    
    static func transactionGroupDateString(from date: Date) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterGet.dateFormat = DateFormat.general.rawValue

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterPrint.dateFormat = DateFormat.dailyGroupedTransactions.rawValue

        return dateFormatterPrint.string(from: date)
    }
    
    static func isTodayDate(_ date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.transaction.rawValue

        let todayDateString = dateFormatter.string(from: Date())
        let dateString = dateFormatter.string(from: date)

        return dateString == todayDateString
    }

    static func isYesterdayDate(_ date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.transaction.rawValue
        
        guard let yesterday = Date.yesterday else { return false }

        let yesterdayDateString = dateFormatter.string(from: yesterday)
        let dateString = dateFormatter.string(from: date)

        return dateString == yesterdayDateString
    }
    
}

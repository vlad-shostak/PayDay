//
//  DateExtension.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

extension Date {
    
    static var yesterday: Date? {
        Date().dayBefore
    }
    
    static var tomorrow: Date? {
        Date().dayAfter
    }

    var dayBefore: Date? {
        noon.flatMap {
            Calendar.current.date(
                byAdding: .day,
                value: -1,
                to: $0
            )
        }
    }

    var dayAfter: Date? {
        noon.flatMap {
            Calendar.current.date(
                byAdding: .day,
                value: 1,
                to: $0
            )
        }
    }

    var noon: Date? {
        Calendar.current.date(
            bySettingHour: 12,
            minute: 0,
            second: 0,
            of: self
        )
    }
    
}

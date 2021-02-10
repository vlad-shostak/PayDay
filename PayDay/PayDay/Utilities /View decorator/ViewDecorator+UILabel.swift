//
//  ViewDecorator+UILabel.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension ViewDecorator where View: UILabel {
    
    static func textColor(_ color: UIColor) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.textColor = color
        }
    }
    
}

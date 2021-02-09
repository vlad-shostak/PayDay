//
//  ViewDecorator+UIView.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension ViewDecorator where View: UIView {
    
    static func borderColor(_ color: UIColor) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.layer.borderColor = color.cgColor
        }
    }
    
    static func borderWidth(_ width: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.layer.borderWidth = width
        }
    }
    
}

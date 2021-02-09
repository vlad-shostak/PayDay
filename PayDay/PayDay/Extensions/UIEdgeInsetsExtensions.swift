//
//  UIEdgeInsetsExtensions.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension UIEdgeInsets {

    static func insets(top: CGFloat = 0,
                       left: CGFloat = 0,
                       bottom: CGFloat = 0,
                       right: CGFloat = 0) -> Self {
        Self(top: top, left: left, bottom: bottom, right: right)
    }
    
}

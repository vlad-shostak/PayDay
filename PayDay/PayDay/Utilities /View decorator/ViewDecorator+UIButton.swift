//
//  ViewDecorator+UIButton.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension ViewDecorator where View: UIButton {
    
    static func title(_ title: String) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.setTitle(title, for: .normal)
        }
    }
    
    static func titleColor(_ color: UIColor) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.setTitleColor(color, for: .normal)
        }
    }
    
    static var `default`: ViewDecorator<View> {
        let height: CGFloat = 50
        
        return ViewDecorator<View> {
            $0.decorated(with: .titleColor(.white))
            $0.decorated(with: .filled(.vivid))
            $0.decorated(with: .height(height))
            $0.decorated(with: .rounded(radius: height / 3))
        }
    }
    
}

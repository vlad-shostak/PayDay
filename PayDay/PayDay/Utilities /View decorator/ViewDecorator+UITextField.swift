//
//  ViewDecorator+UITextField.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension ViewDecorator where View: TextFieldWithInsets {
    
    static func textInsets(_ textInsets: UIEdgeInsets) -> ViewDecorator<TextFieldWithInsets> {
        ViewDecorator<TextFieldWithInsets> {
             $0.textInsets = textInsets
        }
    }
    
    static func alignment(_ alignment: NSTextAlignment) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.textAlignment = alignment
        }
    }
    
    static func placeholder(_ placeholder: String) -> Self {
        ViewDecorator {
            $0.placeholder = placeholder
        }
    }
    
    static var `default`: ViewDecorator<View> {
        let height: CGFloat = 50
        
        return ViewDecorator<View> {
            $0.decorated(with: .filled(.alabaster))
            $0.decorated(with: .height(height))
            $0.decorated(with: .rounded(radius: height / 3))
        }
    }
    
}

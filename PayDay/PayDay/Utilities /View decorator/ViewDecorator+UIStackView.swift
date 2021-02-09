//
//  ViewDecorator+UIStackView.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension ViewDecorator where View: UIStackView {
    
    static func vertical(_ spacing: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.spacing = spacing
        }
    }
    
    static func horizontal(_ spacing: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = spacing
        }
    }
    
    static func alignment(_ alignment: UIStackView.Alignment) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.alignment = alignment
        }
    }

    static func distribution(_ distribution: UIStackView.Distribution) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.distribution = distribution
        }
    }
        
}


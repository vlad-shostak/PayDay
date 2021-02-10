//
//  ViewDecorator+UIView.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension ViewDecorator where View: UIView {
    
    static func rounded(radius: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.layer.cornerRadius = radius
        }
    }
    
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
    
    static func size(_ size: CGSize) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.layout {
                $0.size(size)
            }
        }
    }
    
    static func height(_ height: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.layout {
                $0.height.equal(to: height)
            }
        }
    }
    
    static func width(_ width: CGFloat) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.layout {
                $0.width.equal(to: width)
            }
        }
    }
    
    static func filled(_ color: UIColor) -> ViewDecorator<View> {
        ViewDecorator<View> {
            $0.backgroundColor = color
        }
    }
    
}

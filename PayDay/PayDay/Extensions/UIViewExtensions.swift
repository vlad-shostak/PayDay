//
//  UIViewExtensions.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview(_:))
    }
    
    func addTapHandler(_ handler: @escaping () -> Void) {
        addTapHandler { _ in handler() }
    }

    func addTapHandler(_ handler: @escaping (UITapGestureRecognizer) -> Void) {
        isUserInteractionEnabled = true
        
        let tapRec = UITapGestureRecognizer { recognizer in
            if let tapRecognizer = recognizer as? UITapGestureRecognizer, tapRecognizer.state == .recognized {
                handler(tapRecognizer)
            }
        }
        
        tapRec.cancelsTouchesInView = false
        
        addGestureRecognizer(tapRec)
    }
    
}

//
//  ViewDecorator.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

/// The class that stores the view modification and applies it.
struct ViewDecorator<View: UIView> {
    
    // MARK: - Public variables
    
    let decoration: (View) -> Void
    
    // MARK: - Public functions
    
    func decorate(_ view: View) {
        decoration(view)
    }
    
}

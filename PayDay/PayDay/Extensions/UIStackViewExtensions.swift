//
//  UIStackViewExtensions.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ subviews: UIStackView...) {
        subviews.forEach(addArrangedSubview(_:))
    }
    
}


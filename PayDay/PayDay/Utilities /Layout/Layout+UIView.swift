//
//  Layout+UIView.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Prepares the view for autolayout and calls layout block.
    ///
    /// - Parameter closure: The layout block.
    func layout(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }
    
    /// Pins all edges of view to a given view with zero insets.
    ///
    /// This function adds top, bottom, leading and trailinig constraints with zero insets.
    ///
    /// - Parameter view: The view to pin edges.
    func pinAllEdges(to view: UIView) {
        pinAllEdges(to: view, insets: .zero)
    }
    
    /// Pins all edges of view to a given view with specified insets.
    ///
    /// This function adds top, bottom, leading and trailinig constraints with specified insets.
    ///
    /// - Parameters:
    ///   - view: The view to pin edges.
    ///   - insets: The insets for all edges.
    func pinAllEdges(to view: UIView, insets: UIEdgeInsets) {
        layout {
            $0.pin(to: view, insets: insets)
        }
    }

    func addSubview(_ view: UIView, layout: (LayoutProxy) -> Void) {
        addSubview(view)
        view.layout(using: layout)
    }
    
}

//
//  LayoutAnchor.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

/// The protocol describing a factory object for creating layout constraint.
protocol LayoutAnchor: LayoutAnchorType {
    
    /// Returns a constraint that defines one item’s attribute as equal
    /// to another item’s attribute plus a constant offset.
    ///
    /// - Parameters:
    ///   - anchor: The layout anchor.
    ///   - constant: The constant offset for the constraint.
    /// - Returns: An inactive constraint.
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    
    /// Returns a constraint that defines one item’s attribute as greater than or equal
    /// to another item’s attribute plus a constant offset.
    ///
    /// - Parameters:
    ///   - anchor: The layout anchor.
    ///   - constant: The constant offset for the constraint.
    /// - Returns: An inactive constraint.
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    
    /// Returns a constraint that defines one item’s attribute as less than or equal
    /// to another item’s attribute plus a constant offset.
    ///
    /// - Parameters:
    ///   - anchor: The layout anchor.
    ///   - constant: The constant offset for the constraint.
    /// - Returns: An inactive constraint.
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    
}

extension NSLayoutAnchor: LayoutAnchor {}

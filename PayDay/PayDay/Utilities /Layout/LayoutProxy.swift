//
//  LayoutProxy.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

/// A proxy for layout methods of the UIView.
class LayoutProxy {
    
    // MARK: - Public variables
    
    lazy var leading = property(with: view.leadingAnchor)
    lazy var trailing = property(with: view.trailingAnchor)
    lazy var top = property(with: view.topAnchor)
    lazy var bottom = property(with: view.bottomAnchor)
    lazy var width = property(with: view.widthAnchor)
    lazy var height = property(with: view.heightAnchor)
    lazy var centerX = property(with: view.centerXAnchor)
    lazy var centerY = property(with: view.centerYAnchor)
    
    // MARK: - Private variables
    
    private let view: UIView
    
    // MARK: - Initialization
    
    init(view: UIView) {
        self.view = view
    }
    
    // MARK: - Private functions
    
    private func property<A: LayoutAnchor>(with anchor: A) -> LayoutProperty<A> {
        LayoutProperty(anchor: anchor)
    }
    
}

extension LayoutProxy {
    
    /// Pins all edges, excluding some edges, to a given view with a given insets.
    ///
    /// - Parameters:
    ///   - view: The view, to which the edges will be pinned.
    ///   - edgesToExclude: The edges, to which the view should not be pinned.
    ///   - insets: The edge insets.
    /// - Returns: An array of a layout constraints.
    @discardableResult
    func pin(to view: UIView,
             excluding edgesToExclude: [UIRectEdge] = [],
             insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        if !edgesToExclude.contains(.top) {
            let topConstraint = top.equal(to: view.topAnchor, constant: insets.top)
            constraints.append(topConstraint)
        }
        
        if !edgesToExclude.contains(.bottom) {
            let bottomConstraint = bottom.equal(to: view.bottomAnchor, constant: insets.bottom)
            constraints.append(bottomConstraint)
        }
        
        if !edgesToExclude.contains(.left) {
            let leadingConstraint = leading.equal(to: view.leadingAnchor, constant: insets.left)
            constraints.append(leadingConstraint)
        }
        
        if !edgesToExclude.contains(.right) {
            let topConstraint = trailing.equal(to: view.trailingAnchor, constant: insets.right)
            constraints.append(topConstraint)
        }
        
        return constraints
    }
    
    /// Pins all edges, excluding some edges, to a superview with a given insets.
    ///
    /// - Parameters:
    ///   - edgesToExclude: The edges, to which the view should not be pinned.
    ///   - insets: The edge insets.
    /// - Returns: An array of a layout constraints.
    @discardableResult
    func pinToSuperview(excluding edgesToExclude: [UIRectEdge] = [],
                        insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        guard let superview = view.superview else {
            return []
        }
        
        return pin(to: superview, excluding: edgesToExclude, insets: insets)
    }
    
    /// Pins all edges, excluding some edges, to a given layout guide with a given insets.
    ///
    /// - Parameters:
    ///   - layoutGuide: The layout guide, to which the edges will be pinned.
    ///   - edgesToExclude: The edges, to which the view should not be pinned.
    ///   - insets: The edge insets.
    /// - Returns: An array of a layout constraints.
    @discardableResult
    func pin(to layoutGuide: UILayoutGuide,
             excluding edgesToExclude: [UIRectEdge] = [],
             insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        if !edgesToExclude.contains(.top), !edgesToExclude.contains(.all) {
            let topConstraint = top.equal(to: layoutGuide.topAnchor, constant: insets.top)
            constraints.append(topConstraint)
        }
        
        if !edgesToExclude.contains(.bottom), !edgesToExclude.contains(.all) {
            let bottomConstraint = bottom.equal(to: layoutGuide.bottomAnchor, constant: insets.bottom)
            constraints.append(bottomConstraint)
        }
        
        if !edgesToExclude.contains(.left), !edgesToExclude.contains(.all) {
            let leadingConstraint = leading.equal(to: layoutGuide.leadingAnchor, constant: insets.left)
            constraints.append(leadingConstraint)
        }
        
        if !edgesToExclude.contains(.right), !edgesToExclude.contains(.all) {
            let topConstraint = trailing.equal(to: layoutGuide.trailingAnchor, constant: insets.right)
            constraints.append(topConstraint)
        }
        
        return constraints
    }
    
    /// Centers the view regarding to another view.
    ///
    /// - Parameter view: The view, on which to center.
    /// - Returns: An array of a layout constraints.
    @discardableResult
    func center(in view: UIView) -> [NSLayoutConstraint] {
        [
            centerX.equal(to: view.centerXAnchor),
            centerY.equal(to: view.centerYAnchor)
        ]
    }
    
    /// Creates the width and height anchors with given size.
    ///
    /// - Parameter size: The size for the constraints.
    /// - Returns: An array of a layout constraints.
    @discardableResult
    func size(_ size: CGSize) -> [NSLayoutConstraint] {
        [
            width.equal(to: size.width),
            height.equal(to: size.height)
        ]
    }
    
}


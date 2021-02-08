//
//  StackedLayout.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Type statically contains all available layout strategies
    struct LayoutStrategy {
        
        // MARK: - Private variables
        
        private let root: UIView
        
        // MARK: - Initialization
        
        init(container: UIView) {
            self.root = container
        }
        
    }
    
    /// Entry point for layout utils scope
    var layoutUsing: LayoutStrategy {
        LayoutStrategy(container: self)
    }
    
}

extension UIView.LayoutStrategy {
    
    struct Stack {}
    
    /// Use stack as a layout strategy. Then place it to the caller-view's hierarchy
    ///
    /// - Parameter builder: Builder with the scope for stack related operations
    @discardableResult
    func stack(layout: ((UIStackView) -> Void)? = nil,
               builder: ((Stack) -> UIStackView)) -> UIStackView {
        let stackView = builder(Stack())
        
        root.addSubview(stackView)
        
        if let layout = layout {
            layout(stackView)
        } else {
            stackView.pinAllEdges(to: root)
        }
        
        return stackView
    }
    
}

extension UIView.LayoutStrategy.Stack {
    
    /// Horizontally aligned stack view
    ///
    /// - Parameters:
    ///   - alignedTo: Layout transverse to the stacking axis
    ///   - distributedTo: Layout of the arrangedSubviews along the axis
    ///   - views: views to place inside the stack
    /// - Returns: Ready stack view
    @discardableResult
    func hStack(alignedTo: UIStackView.Alignment = .fill,
                distributedTo: UIStackView.Distribution = .fill,
                _ views: UIView...) -> UIStackView {
        stack(
            axis: .horizontal,
            alignedTo: alignedTo,
            distributedTo: distributedTo,
            views
        )
    }
    
    /// Horizontally aligned stack view
    ///
    /// - Parameters:
    ///   - alignedTo: Layout transverse to the stacking axis
    ///   - distributedTo: Layout of the arrangedSubviews along the axis
    ///   - views: views to place inside the stack
    /// - Returns: Ready stack view
    @discardableResult
    func hStack(alignedTo: UIStackView.Alignment = .fill,
                distributedTo: UIStackView.Distribution = .fill,
                _ views: [UIView]) -> UIStackView {
        stack(
            axis: .horizontal,
            alignedTo: alignedTo,
            distributedTo: distributedTo,
            views
        )
    }
    
    /// Vertically aligned stack view
    ///
    /// - Parameters:
    ///   - alignedTo: Layout transverse to the stacking axis
    ///   - distributedTo: Layout of the arrangedSubviews along the axis
    ///   - views: views to place inside the stack
    /// - Returns: Ready stack view
    @discardableResult
    func vStack(alignedTo: UIStackView.Alignment = .fill,
                distributedTo: UIStackView.Distribution = .fill,
                _ views: UIView...) -> UIStackView {
        stack(
            axis: .vertical,
            alignedTo: alignedTo,
            distributedTo: distributedTo,
            views
        )
    }
    
    /// Vertically aligned stack view
    ///
    /// - Parameters:
    ///   - alignedTo: Layout transverse to the stacking axis
    ///   - distributedTo: Layout of the arrangedSubviews along the axis
    ///   - views: views to place inside the stack
    /// - Returns: Ready stack view
    @discardableResult
    func vStack(alignedTo: UIStackView.Alignment = .fill,
                distributedTo: UIStackView.Distribution = .fill,
                _ views: [UIView]) -> UIStackView {
        stack(
            axis: .vertical,
            alignedTo: alignedTo,
            distributedTo: distributedTo,
            views
        )
    }
    
    @discardableResult
    private func stack(axis: NSLayoutConstraint.Axis,
                       alignedTo: UIStackView.Alignment = .fill,
                       distributedTo: UIStackView.Distribution = .fill,
                       _ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.alignment = alignedTo
        stackView.distribution = distributedTo
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
}

extension UIView.LayoutStrategy.Stack {
    
    /// Gap with min/max height
    func vGap(min minHeight: CGFloat,
              max maxHeight: CGFloat? = nil,
              color: UIColor = .clear,
              relatedTo relatedView: UIView? = nil) -> UIView {
        let spacing = GapView(relatedView: relatedView)
        spacing.backgroundColor = color
        spacing.heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight).isActive = true
        
        if let maxHeight = maxHeight {
            spacing.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight).isActive = true
        }
        
        return spacing
    }
    
    /// Vertical gap between arranged subviews
    ///
    /// - Parameter height: height of gap
    /// - Returns: view representing the gap
    func vGap(fixed height: CGFloat) -> UIView {
        vGap(fixed: height, color: .clear)
    }
    
    /// Vertical gap between arranged subviews
    ///
    /// - Parameters:
    ///   - height: height of gap
    ///   - color: color of gap
    /// - Returns: view representing the gap
    func vGap(fixed height: CGFloat? = nil,
              color: UIColor = .clear,
              relatedTo relatedView: UIView? = nil) -> UIView {
        let spacing = GapView(relatedView: relatedView)
        spacing.backgroundColor = color
        
        if let height = height {
            spacing.heightAnchor.constraint(equalToConstant: height).isActive = true
        } else {
            spacing.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            spacing.setContentHuggingPriority(.defaultLow, for: .vertical)
        }

        return spacing
    }
    
    /// Horizontal gap between arranged subviews
    ///
    /// - Parameter width: width of gap
    /// - Returns: view representing the gap
    func hGap(fixed width: CGFloat) -> UIView {
        hGap(fixed: width, color: .clear)
    }
    
    /// Horizontal gap between arranged subviews
    ///
    /// - Parameters:
    ///   - width: width of gap
    ///   - color: color of gap
    /// - Returns: view representing the gap
    func hGap(fixed width: CGFloat? = nil,
              color: UIColor = .clear,
              relatedTo relatedView: UIView? = nil) -> UIView {
        let spacing = GapView(relatedView: relatedView)
        spacing.backgroundColor = color
        
        if let width = width {
            spacing.widthAnchor.constraint(equalToConstant: width).isActive = true
        } else {
            spacing.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            spacing.setContentHuggingPriority(.defaultLow, for: .horizontal)
        }
        
        return spacing
    }
    
    /// Horizontal gap between arranged subviews
    ///
    /// - Parameter width: width of gap
    /// - Returns: view representing the gap
    func hGap(min width: CGFloat) -> UIView {
        let spacing = UIView()
        spacing.widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
        spacing.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        spacing.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return spacing
    }
    
}

private final class GapView: UIView {
    
    // MARK: - Private variables

    private var observation: NSKeyValueObservation?
    
    // MARK: - Initialization

    init(relatedView: UIView?) {
        super.init(frame: .zero)

        observation = relatedView?.observe(\.isHidden, options: [.new]) { [weak self] _, change in
            change.newValue.map {
                self?.isHidden = $0
            }
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


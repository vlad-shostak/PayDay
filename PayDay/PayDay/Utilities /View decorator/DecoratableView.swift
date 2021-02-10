//
//  DecoratableView.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

/// Describes a view, which can be instantiated and modified with some ViewDecorator.
public protocol DecoratableView: UIView {}

extension DecoratableView {
    
    /// Initializes the view with the specified decorator.
    ///
    /// - Parameter decorator: The decorator object to modify the view.
    init(decorator: ViewDecorator<Self>) {
        self.init(frame: .zero)
        
        decorate(with: decorator)
    }
    
    /// Modifies the view with the specified decorator.
    ///
    /// - Parameter decorator: The decorator object to modify the view.
    /// - Returns: A modified view object.
    @discardableResult
    func decorated(with decorator: ViewDecorator<Self>) -> Self {
        decorate(with: decorator)
        
        return self
    }
    
    /// Modifies the view with the specified decorator.
    ///
    /// - Parameter decorator: The decorator object to modify the view.
    func decorate(with decorator: ViewDecorator<Self>) {
        decorator.decorate(self)
        
        currentDecorators.append(decorator)
    }
    
    /// Modifies the view with applied decorators.
    func redecorate() {
        currentDecorators.forEach {
            $0.decorate(self)
        }
    }
    
}

private extension DecoratableView {
    
    var currentDecorators: [ViewDecorator<Self>] {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.decorator) as? [ViewDecorator<Self>] ?? [ViewDecorator<Self>]()
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.decorator,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

}

private enum AssociatedKeys {
    static var decorator = "AssociatedKeys.decorator"
}

extension UIView: DecoratableView {}

//
//  UIBarButtonExtension.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

typealias UIBarButtonItemTargetClosure = (UIBarButtonItem) -> Void

extension UIBarButtonItem {
    
    // MARK: - Private
    
    // MARK: Entities

    private enum AssociatedKeys {
        static var targetClosure = "UIBarButtonItem.targetClosure"
    }

    // MARK: Variables

    private var targetClosure: UIBarButtonItemTargetClosure? {
        get {
            guard
                let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper
            else {
                return nil
            }

            return closureWrapper.closure
        }

        set {
            guard let newValue = newValue else { return }

            objc_setAssociatedObject(self,
                                     &AssociatedKeys.targetClosure,
                                     ClosureWrapper(newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // MARK: - Initialization

    convenience init(title: String?, style: UIBarButtonItem.Style, action: @escaping UIBarButtonItemTargetClosure) {
        self.init(title: title, style: style, target: nil, action: nil)

        self.targetClosure = action

        self.target = self
        self.action = #selector(UIBarButtonItem.closureAction)
    }
    
    // MARK: - Private functions
    
    @objc
    private func closureAction() {
        guard let targetClosure = targetClosure else { return }

        targetClosure(self)
    }

}

private class ClosureWrapper: NSObject {
    
    // MARK: - Public variables

    let closure: UIBarButtonItemTargetClosure
    
    // MARK: - Initialization

    init(_ closure: @escaping UIBarButtonItemTargetClosure) {
        self.closure = closure
    }

}

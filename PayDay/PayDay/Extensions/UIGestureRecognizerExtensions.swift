//
//  UIGestureRecognizerExtensions.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension UIGestureRecognizer {

    typealias Action = (UIGestureRecognizer) -> Void

    convenience init(_ action: @escaping Action) {
        self.init()

        addAction(action)
    }

    func addAction(_ action: @escaping Action) {
        let wrapper = ActionWrapper(action: action)
        
        addTarget(
            wrapper,
            action: #selector(ActionWrapper.onRecognize(sender:))
        )
        
        wrappedActions.append(wrapper)
    }
    
}

// MARK: - Wrapped Actions

private extension UIGestureRecognizer {

    private enum AssociationKeys {
        static var wrappedActions = "wrappedActions"
    }

    var wrappedActions: [ActionWrapper] {
        get {
            objc_getAssociatedObject(self, &AssociationKeys.wrappedActions) as? [ActionWrapper] ?? []
        } set {
            objc_setAssociatedObject(
                self,
                &AssociationKeys.wrappedActions,
                newValue,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

}

private final class ActionWrapper {
    
    // MARK: - Private variables

    private let action: UIGestureRecognizer.Action
    
    // MARK: - Initialization

    init(action: @escaping UIGestureRecognizer.Action) {
        self.action = action
    }
    
    // MARK: - Public functions

    @objc
    func onRecognize(sender: UIGestureRecognizer) {
        action(sender)
    }

}

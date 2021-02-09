//
//  AlertViewTrait.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

protocol AlertDisplayable: AnyObject {
    
    /// Shows alert to the user.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: Additional details about the reason of the alert.
    ///   - actions: Array of actions.
    func showAlert(title: String?,
                   message: String?,
                   actions: [AlertViewModel.Action])
    
    /// Shows alert to the user. Depending on view model alert can be custom or default.
    ///
    /// - Parameters:
    ///   - viewModel: The view model which configure the alert.
    func showAlert(viewModel: AlertViewModel)

}

/// Describes a UIViewController, which is able to show alert.
/// - Note: This protocol implements all methods in extension.
protocol AlertViewTrait: AlertDisplayable {}

extension AlertViewTrait where Self: UIViewController {
    
    func showAlert(viewModel: AlertViewModel) {
        let title = viewModel.title
        let message = viewModel.message
        
        assert(title != nil || message != nil, "Title and message should not be nil")
        assert(!viewModel.actions.isEmpty, "Actions should not be empty")
        
        showAlert(viewModel: viewModel)
    }
    
    func showAlert(title: String?,
                   message: String?,
                   actions: [AlertViewModel.Action]) {
        showAlert(
            viewModel: AlertViewModel(
                title: title,
                message: message,
                actions: actions
            )
        )
    }
    
    // MARK: - Private functions
    
    private func showDefaultAlert(viewModel: AlertViewModel) {
        guard let hostController = topViewController else { return }
        
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        
        configureActionsForAlert(alert, with: viewModel.actions)
        
        if let presentedAlertController = hostController.presentedViewController as? UIAlertController {
            presentedAlertController.dismiss(animated: true) {
                hostController.present(alert, animated: true)
            }
        } else {
            hostController.present(alert, animated: true)
        }
    }

    private func configureActionsForAlert(_ alert: UIAlertController,
                                          with actionViewModels: [AlertViewModel.Action]) {
        actionViewModels.forEach { action in
            var uiAlertAction: UIAlertAction?

            switch action.style {
            case .confirm:
                uiAlertAction = UIAlertAction(title: action.title, style: .default) { _ in
                    action.completion?()
                }
            case .cancel:
                uiAlertAction = UIAlertAction(title: action.title, style: .cancel) { _ in
                    action.completion?()
                }
            case .destructive:
                uiAlertAction = UIAlertAction(title: action.title, style: .destructive) { _ in
                    action.completion?()
                }
            }
            
            uiAlertAction.map(alert.addAction(_:))
        }
    }

}

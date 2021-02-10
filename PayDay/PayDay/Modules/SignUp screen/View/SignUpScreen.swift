//
//  SignUpScreen.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

final class SignUpScreen: BaseScreen {
    
    // MARK: - Public
    
    // MARK: External dependencies
    
    var output: SignUpScreenOutput!
 
    // MARK: - Private
    
    // MARK: UI
    
    private let stackView = UIStackView(decorator: .vertical(8))
    
    // MARK: - Override functions
    
    override func loadView() {
        super.loadView()
        
        setupNavingationBar()
        setupView()
        setupLayout()
    }
    
}

// MARK: - SignUpScreenInput

extension SignUpScreen: SignUpScreenInput {
    
    func configureScreen(with model: Model) {
        model.subviewRepresentations.forEach {
            switch $0 {
            case .field(let model):
                stackView.addArrangedSubview(
                    FieldWithTitle().configured(with: model)
                )
            case .segmentedControl(let model):
                stackView.addArrangedSubview(
                    SignUpSegmentedControl().configured(with: model)
                )
            case .dateView(let model):
                stackView.addArrangedSubview(
                    SignUpDateView().configured(with: model)
                )
            case let .button(model):
                let button = UIButton()
                    .decorated(with: .default)
                    .decorated(with: .title(model.title))
                
                button.addTapHandler {
                    model.onTap()
                }
                
                stackView.addArrangedSubview(button)
            case .gap(let height):
                stackView.addArrangedSubview(
                    UIView(decorator: .height(height))
                )
            }
        }
    }
    
}

// MARK: - Private functions

private extension SignUpScreen {
    
    func setupNavingationBar() {
        title = "Sign Up"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Sign In",
            style: .plain
        ) { [weak self] _ in
            self?.output.didAskToSignIn()
        }
    }
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func setupLayout() {
        view.layoutUsing.stack(
            layout: {
                $0.layout {
                    $0.pin(
                        to: self.view.safeAreaLayoutGuide,
                        insets: .insets(top: 16, left: 16, bottom: -16, right: -16)
                    )
                }
            },
            builder: {
                $0.vStack(
                    stackView,
                    $0.vGap()
                )
            }
        )
    }
    
}

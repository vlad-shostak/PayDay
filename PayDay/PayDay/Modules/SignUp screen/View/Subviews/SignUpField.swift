//
//  SignUpField.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

final class SignUpField: UIView {
    
    // MARK: - Public
    
    // MARK: Typealises
    
    typealias FieldValueChangeCompletion = (String) -> Void
    
    // MARK: - Private
    
    // MARK: UI
    
    private let titleLabel = UILabel()
    
    private let textField = UITextField()
        .decorated(with: .borderColor(.black))
        .decorated(with: .borderWidth(1))
    
    // MARK: Variables
    
    private var onValueChange: FieldValueChangeCompletion?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupTextField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ConfigurableView

extension SignUpField: ConfigurableView {
    
    struct Model {
        let title: String
        let placeholder: String
        let onValueChange: FieldValueChangeCompletion
    }
    
    func configure(model: Model) {
        titleLabel.text = model.title
        textField.placeholder = model.placeholder
        
        onValueChange = model.onValueChange
    }
    
}

// MARK: - Private functions

private extension SignUpField {
    
    func setupLayout() {
        layoutUsing.stack {
            $0.vStack(
                titleLabel,
                $0.vGap(fixed: 8),
                textField
            )
        }
    }
    
    func setupTextField() {
        textField.addTarget(
            self,
            action: #selector(textFieldValueChanged),
            for: .editingChanged
        )
    }
    
    @objc
    func textFieldValueChanged() {
        guard let text = textField.text else { return }
        
        onValueChange?(text)
    }
    
}
